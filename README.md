# numpy_system_load

This repository illustrates a potential issue with parallel numpy processes resulting in substantial system load. To reproduce the problem, run the following commands:

1. `make image` to build the docker image
2. `make run/workers` to start the workers (the number of workers is equal to the number of CPU cores of your machine by default but can be modified by setting the environment variable `NUM_PROCS`)
3. In a separate terminal run
    1. `make exec/strace` to collect `strace` summaries from one of the workers for ten seconds
    2. `make exec/htop` to monitor CPU use

On a GCP machine with 64 cores, the output of `make exec/strace` is:

```
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 99.96    2.340887        4425       529           brk
  0.03    0.000809           5       176           rt_sigaction
  0.01    0.000169           2        88           rt_sigprocmask
  0.00    0.000027          27         1           write
  0.00    0.000002           2         1           getpid
------ ----------- ----------- --------- --------- ----------------
100.00    2.341894                   795           total
```

In other words, the process spends about 23% of its time waiting for `brk`.

Running only a single worker by setting `NUM_PROCS=1`, the output of `make exec/strace` is:

```
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 95.94    0.061604          16      3910           brk
  2.92    0.001876           1      1302           rt_sigaction
  1.11    0.000715           1       651           rt_sigprocmask
  0.02    0.000012           2         7           write
  0.01    0.000006           1         7           getpid
------ ----------- ----------- --------- --------- ----------------
100.00    0.064213                  5877           total
```

I.e., the process spends only 0.6% of its time waiting for `brk`.
