
get_solution_env <- function(solution_code, envir_prep) {
  env <- new.env(parent = envir_prep)
  eval(parse(text = solution_code), envir = env)
  env
}

# ---------- object extraction ----------

extract_scalars <- function(env, include = NULL) {
  objs <- ls(env)

  vals <- unlist(lapply(objs, function(x) {
    v <- get(x, envir = env)
    if (is.numeric(v) && length(v) == 1) v else NULL
  }))

  if (!is.null(include) && is.numeric(include) && length(include) == 1) {
    vals <- c(vals, include)
  }

  vals
}

extract_tables <- function(env, include = NULL) {
  objs <- ls(env)

  out <- lapply(objs, function(x) {
    v <- get(x, envir = env)
    if (inherits(v, "table")) v else NULL
  })

  out <- Filter(Negate(is.null), out)

  if (!is.null(include) && inherits(include, "table")) {
    out <- c(out, list(include))
  }

  out
}

# ---------- matching ----------

has_scalar <- function(values, target, tol = 1e-8) {
  any(abs(values - target) < tol, na.rm = TRUE)
}

has_table <- function(tables, target) {
  any(vapply(tables, function(x) isTRUE(all.equal(x, target)), logical(1)))
}

# ---------- target extraction ----------
# If the solution created objects, use them.
# Otherwise fall back to .solution as one target named ".result".
extract_targets_from_solution <- function(solution_env, solution_code, solution_result = NULL) {
  expr <- parse(text = solution_code, keep.source = FALSE)
  objs <- vapply(Filter(function(e) is.call(e) && identical(as.character(e[[1]]), "<-"), as.list(expr)), function(e) as.character(e[[2]]), character(1))

  if (length(objs) == 0 && !is.null(solution_result)) {
    value <- solution_result
    type <- if (is.numeric(value) && length(value) == 1) {
      "scalar"
    } else if (inherits(value, "table")) {
      "table"
    } else {
      "other"
    }

    return(list(list(
      name = ".result",
      type = type,
      value = value
    )))
  }

  lapply(objs, function(obj_name) {
    value <- get(obj_name, envir = solution_env)

    type <- if (is.numeric(value) && length(value) == 1) {
      "scalar"
    } else if (inherits(value, "table")) {
      "table"
    } else {
      "other"
    }

    list(
      name = obj_name,
      type = type,
      value = value
    )
  })
}

# ---------- checking targets ----------

check_targets <- function(targets, user_env, user_result = NULL, tol = 1e-8) {
  user_scalars <- extract_scalars(user_env, include = user_result)
  user_tables  <- extract_tables(user_env, include = user_result)

  lapply(targets, function(trg) {
    found <- switch(
      trg$type,
      scalar = has_scalar(user_scalars, trg$value, tol = tol),
      table  = has_table(user_tables, trg$value),
      FALSE
    )

    list(
      name = trg$name,
      type = trg$type,
      found = found
    )
  })
}

# ---------- code parsing ----------
# Parse code and collect all function calls recursively.

collect_calls <- function(code) {
  expr <- parse(text = code, keep.source = FALSE)
  calls <- list()

  walk <- function(x) {
    if (is.expression(x)) {
      for (i in seq_along(x)) walk(x[[i]])
    } else if (is.call(x)) {
      calls[[length(calls) + 1]] <<- x
      for (i in 2:length(x)) walk(x[[i]])
    } else if (is.pairlist(x)) {
      for (i in seq_along(x)) walk(x[[i]])
    }
  }

  walk(expr)
  calls
}

call_name <- function(cl) {
  head <- cl[[1]]
  if (is.symbol(head)) {
    as.character(head)
  } else {
    paste(deparse(head), collapse = "")
  }
}

find_calls_to <- function(code, fun) {
  calls <- collect_calls(code)
  Filter(function(cl) identical(call_name(cl), fun), calls)
}

# ---------- function usage ----------

used_functions <- function(code, funs) {
  out <- vapply(funs, function(f) {
    length(find_calls_to(code, f)) > 0
  }, logical(1))

  stats::setNames(out, funs)
}

# ---------- argument usage ----------
# Supports both named and positional arguments.
# Example:
# arg_spec = list(use = list(position = 3, value = "complete.obs"))

get_call_arg <- function(cl, arg_name = NULL, position = NULL) {
  nms <- names(cl)

  # named argument
  if (!is.null(arg_name) && arg_name %in% nms) {
    return(cl[[which(nms == arg_name)[1]]])
  }

  # positional argument (counted among function arguments, not including function name)
  if (!is.null(position)) {
    idx <- position + 1
    if (length(cl) >= idx) {
      nm <- nms[idx]
      if (is.null(nm) || identical(nm, "")) {
        return(cl[[idx]])
      }
    }
  }

  NULL
}

call_uses_arg <- function(cl, arg_name = NULL, position = NULL) {
  !is.null(get_call_arg(cl, arg_name = arg_name, position = position))
}

arg_used_in_calls <- function(calls, arg_name = NULL, position = NULL) {
  any(vapply(calls, function(cl) {
    call_uses_arg(cl, arg_name = arg_name, position = position)
  }, logical(1)))
}

# ---------- argument values ----------
# Evaluate the used argument expression in the user's result environment if possible.

arg_value_matches_in_calls <- function(calls, user_env, expected,
                                       arg_name = NULL, position = NULL) {
  for (cl in calls) {
    arg_expr <- get_call_arg(cl, arg_name = arg_name, position = position)
    if (is.null(arg_expr)) next

    val <- try(eval(arg_expr, envir = user_env), silent = TRUE)
    if (inherits(val, "try-error")) next

    if (isTRUE(all.equal(val, expected))) {
      return(TRUE)
    }
  }
  FALSE
}

# ---------- suggestion logic ----------
# suggestion_map structure:
#
# list(
#   ".result" = list(
#     functions = c("cor"),
#     args = list(
#       cor = list(
#         use = list(position = 3, value = "complete.obs")
#       )
#     )
#   )
# )

suggest_code_features_for_missing_targets <- function(checks, user_code, user_env, suggestion_map) {
  missing <- checks[!vapply(checks, function(x) x$found, logical(1))]
  if (length(missing) == 0) return(NULL)

  missing_names <- vapply(missing, function(x) x$name, character(1))

  for (target_name in missing_names) {
    spec <- suggestion_map[[target_name]]
    if (is.null(spec)) next
    if (is.atomic(spec)) spec <- list(functions = spec, args = list())

    # 1) function hints
    funs <- spec$functions %||% character()
    if (length(funs) > 0) {
      used <- used_functions(user_code, funs)
      missing_funs <- names(used)[!used]

      if (length(missing_funs) > 0) {
        return(
          paste0(
            "Noch nicht ganz richtig (`", target_name, "`). ",
            "Ich hätte hier vielleicht die Funktionen ",
            paste(sprintf("`%s()`", missing_funs), collapse = ", "),
            " erwartet, obwohl auch andere korrekte Lösungen möglich sein können."
          )
        )
      }
    }

    # 2) argument-name / position hints
    arg_specs <- spec$args %||% list()
    for (fun in names(arg_specs)) {
      calls <- find_calls_to(user_code, fun)
      if (length(calls) == 0) next

      for (arg_nm in names(arg_specs[[fun]])) {
        a <- arg_specs[[fun]][[arg_nm]]
        pos <- a$position %||% NULL

        if (!arg_used_in_calls(calls, arg_name = arg_nm, position = pos)) {
          return(
            paste0(
              "Noch nicht ganz richtig (`", target_name, "`). ",
              "Ich hätte bei `", fun, "()` wahrscheinlich das Argument ",
              "`", arg_nm, "` erwartet",
              #if (!is.null(pos)) paste0(" (bzw. die entsprechende Position ", pos, ")") else "",
              ", obwohl auch andere Lösungen möglich sind."
            )
          )
        }
      }
    }

    # 3) argument-value hints
    for (fun in names(arg_specs)) {
      calls <- find_calls_to(user_code, fun)
      if (length(calls) == 0) next

      for (arg_nm in names(arg_specs[[fun]])) {
        a <- arg_specs[[fun]][[arg_nm]]
        pos <- a$position %||% NULL

        if (!is.null(a$value) &&
            arg_used_in_calls(calls, arg_name = arg_nm, position = pos) &&
            !arg_value_matches_in_calls(calls, user_env, a$value,
                                        arg_name = arg_nm, position = pos)) {
          return(
            paste0(
              "Noch nicht ganz richtig (`", target_name, "`). ",
              "Das Argument `", arg_nm, "` in `", fun, "()` scheint noch nicht zu stimmen."
            )
          )
        }
      }
    }
  }

  NULL
}

`%||%` <- function(x, y) if (is.null(x)) y else x

# ---------- main grader ----------

#' @export
grade_targets_with_soft_hints <- function(
    user_env,
    user_result,
    user_code,
    solution_code,
    solution_result,
    envir_prep,
    suggestion_map = list(),
    tol = 1e-8,
    success_message = "Richtig.",
    generic_fail_message = "Noch nicht ganz richtig."
) {
  sol_env  <- get_solution_env(solution_code, envir_prep)
  targets  <- extract_targets_from_solution(sol_env, solution_code = solution_code, solution_result = solution_result)
  checks   <- check_targets(targets, user_env, user_result = user_result, tol = tol)

  all_found <- all(vapply(checks, function(x) x$found, logical(1)))
  if (all_found) {
    pass(success_message)
  }

  soft_hint <- suggest_code_features_for_missing_targets(
    checks = checks,
    user_code = user_code,
    user_env = user_env,
    suggestion_map = suggestion_map
  )

  if (!is.null(soft_hint)) {
    fail(soft_hint, hint = TRUE)
  }

  fail(
    paste0(
      generic_fail_message,
      " Probleme bei: ",
      paste(vapply(checks[!vapply(checks, function(x) x$found, logical(1))],
                   function(x) x$name, character(1)),
            collapse = ", "),
      "."
    ),
    hint = TRUE
  )
}

`%||%` <- function(x, y) if (is.null(x)) y else x

call_name <- function(cl) {
  head <- cl[[1]]
  if (is.symbol(head)) {
    as.character(head)
  } else {
    paste(deparse(head), collapse = "")
  }
}

collect_calls_recursive <- function(expr) {
  calls <- list()

  walk <- function(x) {
    if (is.call(x)) {
      calls[[length(calls) + 1]] <<- x
      for (i in seq_along(x)[-1]) {
        walk(x[[i]])
      }
    } else if (is.expression(x)) {
      for (i in seq_along(x)) walk(x[[i]])
    }
  }

  walk(expr)
  calls
}
extract_call_args <- function(cl, keep_values = TRUE, eval_env = baseenv()) {
  nms <- names(cl) %||% rep("", length(cl))
  out <- list()

  fn <- call_name(cl)
  formal_names <- try(names(formals(match.fun(fn))), silent = TRUE)
  if (inherits(formal_names, "try-error")) formal_names <- character()

  if (length(cl) <= 1) return(out)

  for (i in 2:length(cl)) {
    nm <- nms[i]
    supplied_pos <- i - 1
    arg_expr <- cl[[i]]

    # if unnamed, try to recover the formal argument name from the function
    if (identical(nm, "") && length(formal_names) >= supplied_pos) {
      nm <- formal_names[supplied_pos]
    }

    pos <- if (!identical(nm, "") && nm %in% formal_names) match(nm, formal_names) else supplied_pos
    arg_expr <- cl[[i]]

    # if unnamed, try to recover the formal argument name from the function
    if (identical(nm, "") && length(formal_names) >= pos) {
      nm <- formal_names[pos]
    }

    if (!identical(nm, "")) {
      entry <- if (!identical(nms[i], "")) list(position = NULL) else list(position = pos)
      if (keep_values) {
        val <- try(eval(arg_expr, envir = eval_env), silent = TRUE)
        if (!inherits(val, "try-error")) {
          entry$value <- val
        } else {
          entry$expr <- paste(deparse(arg_expr), collapse = "")
        }
      }
      out[[nm]] <- entry
    }
  }

  out
}

#'@export
infer_suggestion_map_from_solution <- function(solution_code, keep_values = TRUE, eval_env = baseenv()) {
  expr <- parse(text = solution_code, keep.source = FALSE)

  make_spec <- function(rhs) {
    calls <- collect_calls_recursive(rhs)
    funs <- unique(vapply(calls, call_name, character(1)))

    args <- list()
    for (cl in calls) {
      fn <- call_name(cl)
      args[[fn]] <- modifyList(args[[fn]] %||% list(), extract_call_args(cl, keep_values, eval_env = eval_env))
    }

    list(
      functions = funs,
      args = args
    )
  }

  out <- list()

  for (i in seq_along(expr)) {
    e <- expr[[i]]

    if (is.call(e) && identical(as.character(e[[1]]), "<-")) {
      lhs <- as.character(e[[2]])
      rhs <- e[[3]]
      out[[lhs]] <- make_spec(rhs)
    } else {
      out[[".result"]] <- make_spec(e)
    }
  }

  out
}

#' @export
grade_auto <- function(
    success_message = "Richtig!",
    generic_fail_message = "Noch nicht ganz richtig.",
    tol = 1e-8,
    env = parent.frame()
) {
  suggestion_map <- infer_suggestion_map_from_solution(
    get(".solution_code", envir = env),
    eval_env = get(".envir_prep", envir = env)
  )

  grade_targets_with_soft_hints(
    user_env = get(".envir_result", envir = env),
    user_result = get(".result", envir = env),
    user_code = get(".user_code", envir = env),
    solution_code = get(".solution_code", envir = env),
    solution_result = get(".solution", envir = env),
    envir_prep = get(".envir_prep", envir = env),
    suggestion_map = suggestion_map,
    tol = tol,
    success_message = success_message,
    generic_fail_message = generic_fail_message
  )
}
