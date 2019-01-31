FROM rocker/verse:3.5.2

# add shiny server
RUN export ADD=shiny && bash /etc/cont-init.d/add

# install linux system dependencies
RUN apt-get update -y && \
	apt-get install -y \
		curl \
libzmq3-dev

# install R dependencies
RUN R -e "install.packages(c('gapminder', 'future', 'clustermq', 'furrr', 'batchtools', 'future.batchtools'), Ncpus=parallel::detectCores())"
RUN R -e "remotes::install_github('ropensci/drake')"

# install plumber
RUN R -e "install.packages(c('plumber'))"

# install gapminderpl
COPY . /gapminderpl
RUN R -e "devtools::install('/gapminderpl', dependencies=FALSE, upgrade_dependencies=FALSE, build_vignettes=TRUE)"  && \
	rm -rf /gapminderpl

#configure shiny server
COPY ./docker/shiny-server.conf /etc/shiny-server/shiny-server.conf
COPY ./inst/shiny/test_viz_app.R /home/rstudio/ShinyApps/gapminderpl/test_viz_app/app.R
RUN chown -hR rstudio:rstudio /home/rstudio/ShinyApps

# configure plumber
COPY ./inst/plumber /plumber/plumber-apis
