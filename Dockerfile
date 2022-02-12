# get the base image, the rocker/verse has R, RStudio and pandoc
FROM rocker/verse:4.0.3

# required
MAINTAINER Ben Marwick <bmarwick@uw.edu>

COPY . /maualithicspaper

# go into the repo directory
RUN . /etc/environment \
  RUN  R -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))" \
  && R -e "remotes::install_github('rstudio/renv')" \
  # install pkgs we need
  && R -e "renv::restore()" \
  # render the manuscript into a docx, you'll need to edit this if you've
  # customised the location and name of your main Rmd file
  # render the manuscript into a docx
  && R -e "rmarkdown::render('maualithicspaper/analysis/paper/paper.Rmd')"
