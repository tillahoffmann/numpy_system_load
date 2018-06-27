#!/usr/bin/env python

import logging
logging.basicConfig(level='INFO')
import os
import time
import numpy as np
from scipy import signal

samples = np.random.normal(0, 1, 264600)
sample_rate = 8820

period = 100
pid = os.getpid()

i = 0
start = time.time()
num_procs = int(os.environ.get('NUM_PROCS', 1))

while True:
    signal.spectrogram(samples, sample_rate, window='hann', nperseg=512, noverlap=256)
    i += 1

    if i % period == 0:
        end = time.time()
        rate = period / (end - start)
        logging.info(f"PID {pid}: {rate}/s (estimated total {rate * num_procs}/s)")
        start = end
