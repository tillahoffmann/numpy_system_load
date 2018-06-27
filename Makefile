TAG = numpy_system_load
NUM_PROCS ?= $(shell getconf _NPROCESSORS_ONLN)
NAME ?= $(TAG)
DOCKER_RUN = docker run --rm -it --name=$(NAME) -e NUM_PROCS=$(NUM_PROCS) $(TAG)

image :
	docker build -t $(TAG) .

run/workers :
	$(DOCKER_RUN) supervisord -c supervisord.conf

run/% :
	$(DOCKER_RUN) $*

exec/% :
	docker exec -it $(NAME) $*
