# todos:
# - make separate user
FROM rocker/r-ver:4

MAINTAINER Johannes Titz

# system libraries of general use; is this really required or can we just use
# the glue from below?
#RUN apt-get update && apt-get install -y \
    #sudo \
    #pandoc-citeproc \
    #libcurl4-gnutls-dev \
    #libcairo2-dev \
    #libxt-dev \
    #libssh2-1-dev \
    #libssl1.1

# with mimosa::glue_sys...
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
  cmake \
  git \
  gsfonts \
  imagemagick \
  libcurl4-openssl-dev \
  libfreetype6-dev \
  libglpk-dev \
  libgmp3-dev \
  libicu-dev \
  libjpeg-dev \
  libmagick++-dev \
  libpng-dev \
  libssl-dev \
  libxml2-dev \
  make \
  pandoc \
  zlib1g-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir /root/rlernen.de
WORKDIR /root/rlernen.de

# Run R -e "install.packages('librarian')"

# writeLines(paste0(paste0("'", desc::desc_get_deps()[, 2], "'", collapse = ","), "deps.txt")
Run R -e "install.packages(c('cofad','ez','knitr','learnr','ppcor','printr', \
'psych','qgraph','rmarkdown','shiny','sjPlot','WebPower','librarian','meme',
simpleCache))"

# minimum deps
# Run R -e "librarian::shelf('rmarkdown')"
#Run R -e "librarian::shelf('shiny')"
#Run R -e "librarian::shelf('learnr')"

# remove binaries
RUN strip /usr/local/lib/R/site-library/*/libs/*.so

# now copy everything
# or maybe just copy what is needed?
COPY . .

# RUN ls

# it is still better to install deps beforehand, otherwise they are reinstalled
# every time the dockerfile is build

# need for deps and maybe caching
RUN R -e "rmarkdown::render('tag1.Rmd')"
RUN R -e "rmarkdown::render('tag2.Rmd')"
RUN R -e "rmarkdown::render('tag3.Rmd')"
RUN R -e "rmarkdown::render('tag4.Rmd')"
RUN R -e "rmarkdown::render('tag5.Rmd')"
RUN R -e "rmarkdown::render('tag6.Rmd')"
RUN R -e "rmarkdown::render('tag7.Rmd')"

RUN R -e "rmarkdown::render('faq.Rmd')"

RUN echo "local(options(shiny.port = 3838, shiny.host = '0.0.0.0'))" > .Rprofile

EXPOSE 3838

CMD ["R", "-e", "rmarkdown::run('tag1.Rmd')
