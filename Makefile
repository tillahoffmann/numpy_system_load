TAG = numpy_system_load
NUM_PROCS ?= $(shell getconf _NPROCESSORS_ONLN)
NAME ?= $(TAG)
DOCKER_RUN = docker run --rm -it --name=$(NAME) -e NUM_PROCS=$(NUM_PROCS) --privileged -v `pwd`:/workspace $(TAG)
DOCKER_EXEC = docker exec -it --privileged $(NAME)

image :
	docker build -t $(TAG) .

run/workers :
	mkdir -p profiles
	$(DOCKER_RUN) supervisord -c supervisord.conf

run/% :
	$(DOCKER_RUN) $*

exec/strace :
	$(DOCKER_EXEC) bash -c 'timeout 10 strace -c -p `pgrep -f worker.py | head -n 1`'

exec/% :
	$(DOCKER_EXEC) $*

clean :
	rm -rf profiles
