help:
	@echo Makefile commands:
	@echo
	@echo help: print this help message and exit
	@echo build: build the docker image for gapminderpl
	@echo run:
	@echo     - starts a docker container with the gapminderpl package installed
	@echo     - to use RStudio go to localhost:8789
	@echo     - to use Shiny go to localhost:3839
	@echo     - your home directory on your host machine will be available at /home/rstudio/hostdata
	@echo     - add new Shiny apps to /home/rstudio/ShinyApps
	@echo
	@echo stop: stops the gapminderpl docker container
	@echo remove: removes the gapminderpl docker container


build:
	docker build --file=docker/Dockerfile --tag=gapminderpl .

run: build
	docker run -d -p 8789:8787 -p 3839:3838 \
		-e DISABLE_AUTH=true \
		--name='gapminderpl-rstudio' \
		-v ${HOME}:/home/rstudio/hostdata \
		gapminderpl
	sleep 3;
	open http://localhost:8789/
	open http://localhost:3839/users/rstudio/gapminderpl/

stop:
	docker stop gapminderpl-rstudio

start:
	docker start gapminderpl-rstudio

remove: stop
	docker rm gapminderpl-rstudio
