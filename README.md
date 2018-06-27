# numpy_system_load

This repository illustrates a potential issue with parallel numpy processes resulting in substantial system load. To reproduce the problem, run the following commands:

1. `make image` to build the docker image
2. `make run/workers` to start the workers
3. In a separate terminal run
    1. `make exec/strace` to collect `strace` summaries from one of the workers for ten seconds
    2. `make exec/htop` to monitor CPU use
