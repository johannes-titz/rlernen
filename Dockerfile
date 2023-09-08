# todos:
# - make separate user
FROM rocker/r-ver:4

MAINTAINER Johannes Titz

# system libraries of general use
RUN apt-get update && apt-get install -y \
    sudo \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev \
    libssl1.1

# from pak
RUN apt-get install -y make
RUN apt-get install -y cmake
RUN apt-get install -y libicu-dev
RUN apt-get install -y pandoc
RUN apt-get install -y zlib1g-dev
RUN apt-get install -y libcurl4-openssl-dev
RUN apt-get install -y libssl-dev
RUN apt-get install -y imagemagick
RUN apt-get install -y libmagick++-dev
RUN apt-get install -y gsfonts
RUN apt-get install -y libpng-dev
RUN apt-get install -y libjpeg-dev
RUN apt-get install -y libglpk-dev
RUN apt-get install -y libgmp3-dev
RUN apt-get install -y libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

#RUN R -e "install.packages('pak')"

RUN mkdir /root/rlernen.de
WORKDIR /root/rlernen.de
#COPY DESCRIPTION .
# only copy description first

# does not work
# RUN R -e "pak::local_system_requirements('ubuntu', '20.04', execute = TRUE, sudo = F, echo =T)"

# with librarian this might not really be needed as render should
# do it automatically, but we need librarian for that first?
# RUN R -e "pak::local_install_deps(ask = F)"
# unclear why this does not work the other way
# RUN R -e "pak::pkg_install('sctyner/memer')"
Run R -e "install.packages('librarian')"
# remove binaries
RUN strip /usr/local/lib/R/site-library/*/libs/*.so
# now copy everything
# or maybe just copy what is needed?
COPY . .

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
