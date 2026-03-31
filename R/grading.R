# ---------- helpers ----------

`%||%` <- function(x, y) if (is.null(x)) y else x

# ---------- solution evaluation ----------

get_solution_env <- function(solution_code, envir_prep) {
  env <- new.env(parent = envir_prep)
  eval(parse(text = solution_code), envir = env)
  env
}

# ---------- object extraction ----------

extract_objects <- function(env, include = NULL) {
  objs <- ls(env)
  out <- stats::setNames(lapply(objs, function(x) get(x, envir = env)), objs)

  if (!is.null(include)) {
    out <- c(out, list(.result = include))
  }

  out
}

# ---------- plot helpers ----------

is_plot_call <- function(expr) {
  if (!is.call(expr)) return(FALSE)
  nm <- call_name(expr)

  nm %in% c(
    "plot", "boxplot", "hist", "barplot", "pairs",
    "funnel", "forest", "metafor::funnel", "metafor::forest"
  )
}

downsample_matrix <- function(mat, n = 64) {
  nr <- nrow(mat)
  nc <- ncol(mat)

  r_idx <- cut(seq_len(nr), breaks = n, labels = FALSE)
  c_idx <- cut(seq_len(nc), breaks = n, labels = FALSE)

  out <- matrix(NA_real_, nrow = n, ncol = n)

  for (i in seq_len(n)) {
    rows <- which(r_idx == i)
    for (j in seq_len(n)) {
      cols <- which(c_idx == j)
      out[i, j] <- mean(mat[rows, cols, drop = FALSE])
    }
  }

  out
}

capture_plot_signature <- function(code, env, width = 700, height = 700, res = 96, n = 64) {
  tf <- tempfile(fileext = ".png")

  grDevices::png(filename = tf, width = width, height = height, res = res, bg = "white")
  on.exit({
    if (grDevices::dev.cur() > 1) grDevices::dev.off()
    unlink(tf)
  }, add = TRUE)

  result <- try(eval(parse(text = code), envir = env), silent = TRUE)

  grDevices::dev.off()

  if (inherits(result, "try-error")) {
    return(structure(list(error = TRUE), class = "plot_signature"))
  }

  img <- png::readPNG(tf)

  gray <- if (length(dim(img)) == 3) {
    # RGB -> grayscale
    0.2989 * img[, , 1] + 0.5870 * img[, , 2] + 0.1140 * img[, , 3]
  } else {
    img
  }

  # invert so darker lines/points have larger values
  gray <- 1 - gray

  structure(
    list(
      error = FALSE,
      img = downsample_matrix(gray, n = n)
    ),
    class = "plot_signature"
  )
}

compare_plot_signature <- function(x, y, tol = 0.08) {
  if (!inherits(x, "plot_signature")) return(FALSE)
  if (!inherits(y, "plot_signature")) return(FALSE)
  if (isTRUE(x$error) || isTRUE(y$error)) return(FALSE)

  if (!identical(dim(x$img), dim(y$img))) return(FALSE)

  mean(abs(x$img - y$img)) <= tol
}

# ---------- type detection ----------

detect_target_type <- function(value) {
  if (inherits(value, "plot_signature")) {
    "plot_signature"
  } else if (inherits(value, "rma")) {
    "rma"
  } else if (is.numeric(value) && length(value) == 1) {
    "scalar"
  } else if (inherits(value, "table")) {
    "table"
  } else if (inherits(value, "htest")) {
    "htest"
  } else if (inherits(value, "anova") || inherits(value, "anova.lm")) {
    "anova"
  } else {
    "object"
  }
}

# ---------- comparators ----------

compare_htest <- function(x, y, tol = 1e-8) {
  inherits(x, "htest") &&
    inherits(y, "htest") &&
    isTRUE(all.equal(unname(x$statistic), unname(y$statistic), tolerance = tol)) &&
    isTRUE(all.equal(unname(x$parameter), unname(y$parameter), tolerance = tol)) &&
    isTRUE(all.equal(x$p.value, y$p.value, tolerance = tol)) &&
    isTRUE(all.equal(unname(x$estimate), unname(y$estimate), tolerance = tol))
}

compare_anova <- function(x, y, tol = 1e-8) {
  if (!(inherits(x, "anova") || inherits(x, "anova.lm"))) return(FALSE)
  if (!(inherits(y, "anova") || inherits(y, "anova.lm"))) return(FALSE)

  dx <- as.data.frame(x)
  dy <- as.data.frame(y)

  isTRUE(all.equal(dx, dy, tolerance = tol, check.attributes = FALSE))
}

compare_rma <- function(x, y, tol = 1e-8) {
  if (!inherits(x, "rma") || !inherits(y, "rma")) return(FALSE)

  get_num <- function(obj, name) {
    val <- try(obj[[name]], silent = TRUE)
    if (inherits(val, "try-error") || is.null(val)) return(NULL)
    as.numeric(val)
  }

  bx <- get_num(x, "beta")
  by <- get_num(y, "beta")

  px <- get_num(x, "pval")
  py <- get_num(y, "pval")

  if (is.null(bx) || is.null(by) || is.null(px) || is.null(py)) {
    return(FALSE)
  }

  if (length(bx) != length(by)) return(FALSE)
  if (length(px) != length(py)) return(FALSE)

  isTRUE(all.equal(bx, by, tolerance = tol, check.attributes = FALSE)) &&
    isTRUE(all.equal(px, py, tolerance = tol, check.attributes = FALSE))
}

comparators <- list(
  plot_signature = function(x, y, tol = 0.08) {
    compare_plot_signature(x, y, tol = tol)
  },
  rma = function(x, y, tol = 1e-8) {
    compare_rma(x, y, tol = tol)
  },
  scalar = function(x, y, tol = 1e-8) {
    is.numeric(x) &&
      length(x) == 1 &&
      isTRUE(all.equal(x, y, tolerance = tol))
  },
  table = function(x, y, tol = 1e-8) {
    inherits(x, "table") &&
      isTRUE(all.equal(x, y))
  },
  htest = function(x, y, tol = 1e-8) {
    compare_htest(x, y, tol = tol)
  },
  anova = function(x, y, tol = 1e-8) {
    compare_anova(x, y, tol = tol)
  },
  object = function(x, y, tol = 1e-8) {
    isTRUE(all.equal(x, y, tolerance = tol, check.attributes = FALSE))
  }
)

object_matches <- function(x, target, type, tol = 1e-8) {
  cmp <- comparators[[type]]
  if (is.null(cmp)) return(FALSE)
  cmp(x, target, tol = tol)
}

has_target_object <- function(objects, target, type, tol = 1e-8) {
  any(vapply(objects, function(x) object_matches(x, target, type, tol = tol), logical(1)))
}

# ---------- target extraction ----------
# Extended:
# - assigned objects are still targets
# - top-level plot calls become synthetic targets .plot1, .plot2, ...

extract_targets_from_solution <- function(solution_env, solution_code, solution_result = NULL) {
  expr <- parse(text = solution_code, keep.source = FALSE)

  targets <- list()
  obj_names <- character()
  plot_i <- 0L

  for (i in seq_along(expr)) {
    e <- expr[[i]]

    if (is.call(e) && identical(as.character(e[[1]]), "<-")) {
      obj_name <- as.character(e[[2]])
      obj_names <- c(obj_names, obj_name)

      value <- get(obj_name, envir = solution_env)

      targets[[length(targets) + 1]] <- list(
        name = obj_name,
        type = detect_target_type(value),
        value = value
      )
      next
    }

    if (is_plot_call(e)) {
      plot_i <- plot_i + 1L
      plot_code <- paste(deparse(e), collapse = "\n")

      targets[[length(targets) + 1]] <- list(
        name = paste0(".plot", plot_i),
        type = "plot_signature",
        value = capture_plot_signature(plot_code, solution_env)
      )
    }
  }

  if (length(obj_names) == 0 && plot_i == 0 && !is.null(solution_result)) {
    value <- solution_result

    targets[[length(targets) + 1]] <- list(
      name = ".result",
      type = detect_target_type(value),
      value = value
    )
  }

  targets
}

# ---------- checking targets ----------
# Extended:
# - plot targets are checked by rendering the user's whole code off-screen

check_targets <- function(targets, user_env, user_result = NULL, user_code = NULL, tol = 1e-8) {
  user_objects <- extract_objects(user_env, include = user_result)

  needs_plot_check <- any(vapply(targets, function(x) identical(x$type, "plot_signature"), logical(1)))

  user_plot <- NULL
  if (needs_plot_check && !is.null(user_code)) {
    user_plot <- try(capture_plot_signature(user_code, user_env), silent = TRUE)
  }

  lapply(targets, function(trg) {
    found <- if (identical(trg$type, "plot_signature")) {
      !inherits(user_plot, "try-error") &&
        compare_plot_signature(user_plot, trg$value, tol = tol)
    } else {
      has_target_object(
        objects = user_objects,
        target = trg$value,
        type = trg$type,
        tol = tol
      )
    }

    list(
      name = trg$name,
      type = trg$type,
      found = found
    )
  })
}

# ---------- code parsing ----------

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

get_call_arg <- function(cl, arg_name = NULL, position = NULL) {
  nms <- names(cl)

  if (!is.null(arg_name) && arg_name %in% nms) {
    return(cl[[which(nms == arg_name)[1]]])
  }

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

    funs <- spec$functions %||% character()
    if (length(funs) > 0) {
      used <- used_functions(user_code, funs)
      missing_funs <- names(used)[!used]

      if (length(missing_funs) > 0) {
        return(
          paste0(
            "Noch nicht ganz richtig (`", target_name, "`). ",
            "Ich h\u00e4tte hier vielleicht die Funktionen ",
            paste(sprintf("`%s()`", missing_funs), collapse = ", "),
            " erwartet, obwohl auch andere korrekte L\u00F6sungen m\u00F6glich sein k\u00F6nnen."
          )
        )
      }
    }

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
              "Ich h\u00e4tte bei `", fun, "()` wahrscheinlich das Argument ",
              "`", arg_nm, "` erwartet",
              ", obwohl auch andere L\u00F6sungen m\u00F6glich sind."
            )
          )
        }
      }
    }

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
              "Der Wert des Arguments `", arg_nm, "` in `", fun, "()` scheint noch nicht zu stimmen."
            )
          )
        }
      }
    }
  }

  NULL
}

# ---------- main grader ----------

#' Grade targets with soft hints based on the solution code.
#' This function checks if the user's solution contains the expected target objects (e.g., variables, results) as defined in the solution code. If not, it provides soft hints based on the functions and arguments used in the user's code compared to the solution.
#'
#' @param user_env The environment containing the user's solution objects.
#' @param user_result The result of the user's code execution (if applicable).
#' @param user_code The user's code as a character string.
#' @param solution_code The solution code as a character string.
#' @param solution_result The expected result of the solution code execution (if applicable).
#' @param envir_prep The environment used for preparing the solution environment.
#' @param suggestion_map A list defining which functions and arguments to check for generating hints.
#' @param tol Numeric tolerance for comparing numeric results (default: 1e-8).
#' @param success_message Message to display when the user's solution is correct.
#' @param generic_fail_message Message to display when the user's solution is incorrect, without specific
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
  targets  <- extract_targets_from_solution(
    sol_env,
    solution_code = solution_code,
    solution_result = solution_result
  )
  checks   <- check_targets(
    targets,
    user_env,
    user_result = user_result,
    user_code = user_code,
    tol = tol
  )

  all_found <- all(vapply(checks, function(x) x$found, logical(1)))
  if (all_found) {
    gradethis::pass(success_message)
  }

  soft_hint <- suggest_code_features_for_missing_targets(
    checks = checks,
    user_code = user_code,
    user_env = user_env,
    suggestion_map = suggestion_map
  )

  if (!is.null(soft_hint)) {
    gradethis::fail(soft_hint, hint = TRUE)
  }

  gradethis::fail(
    paste0(
      generic_fail_message,
      " Probleme bei: ",
      paste(
        vapply(
          checks[!vapply(checks, function(x) x$found, logical(1))],
          function(x) x$name,
          character(1)
        ),
        collapse = ", "
      ),
      "."
    ),
    hint = TRUE
  )
}

# ---------- call extraction for auto suggestion map ----------

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

    if (identical(nm, "") && length(formal_names) >= supplied_pos) {
      nm <- formal_names[supplied_pos]
    }

    pos <- if (!identical(nm, "") && nm %in% formal_names) match(nm, formal_names) else supplied_pos

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

#' Infer a suggestion map from the solution code.
#'
#' This function parses the solution code to identify which functions and arguments are used in the solution. It constructs a suggestion map that can be used to provide targeted hints to the user based on their code.
#'
#' @param solution_code The solution code as a character string.
#' @param keep_values Whether to keep the evaluated argument values in the suggestion map (default)
#' @param eval_env The environment in which to evaluate argument expressions for value extraction (default: baseenv())
#' @export
infer_suggestion_map_from_solution <- function(solution_code, keep_values = TRUE, eval_env = baseenv()) {
  expr <- parse(text = solution_code, keep.source = FALSE)

  make_spec <- function(rhs) {
    calls <- collect_calls_recursive(rhs)
    funs <- unique(vapply(calls, call_name, character(1)))

    args <- list()
    for (cl in calls) {
      fn <- call_name(cl)
      args[[fn]] <- utils::modifyList(args[[fn]] %||% list(), extract_call_args(cl, keep_values, eval_env = eval_env))
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
    } else if (is_plot_call(e)) {
      out[[paste0(".plot", i)]] <- make_spec(e)
    } else {
      out[[".result"]] <- make_spec(e)
    }
  }

  out
}

#' rlernen's autograder
#'
#' Grades the user's solution with automatic hint generation based on the solution code.
#' @param success_message Message to display when the user's solution is correct.
#' @param generic_fail_message Message to display when the user's solution is incorrect, without specific hints.
#' @param tol Numeric tolerance for comparing numeric results (default: 1e-8).
#' @param env The environment containing the necessary objects for grading (default: parent.frame())
#'
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
