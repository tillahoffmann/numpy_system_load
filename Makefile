TAG = numpy_system_load
NUM_PROCS ?= $(shell getconf _NPROCESSORS_ONLN)
NAME ?= $(TAG)
DOCKER_RUN = docker run --rm -it --name=$(NAME) -e NUM_PROCS=$(NUM_PROCS) --privileged $(TAG)
BASE_IMAGE ?= gcr.io/creator-audio/bionic_sonalytic:master

image :
	docker build -t $(TAG) --build-arg BASE_IMAGE=$(BASE_IMAGE) .

run/workers :
	$(DOCKER_RUN) supervisord -c supervisord.conf

run/% :
	$(DOCKER_RUN) $*

exec/% :
	docker exec -it --privileged $(NAME) $*
