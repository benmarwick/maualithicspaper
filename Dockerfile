# get the base image, the rocker/verse has R, RStudio and pandoc
FROM rocker/verse:4.0.3

# required
MAINTAINER Ben Marwick <bmarwick@uw.edu>

COPY . /maualithicspaper

# go into the repo directory
RUN . /etc/environment \
  && sudo apt-get update \
  && sudo apt-get install libudunits2-dev -y \
  # build this compendium package
  && R -e "devtools::install('/maualithicspaper', dep=TRUE)" \
  # render the manuscript into a docx, you'll need to edit this if you've
  # customised the location and name of your main Rmd file
  # render the manuscript into a docx
  && R -e "rmarkdown::render('analysis/paper/paper.Rmd')"
