import numpy as np
from scipy import signal

samples = np.random.normal(0, 1, 264600)
sample_rate = 8820

while True:
    signal.spectrogram(samples, sample_rate, window='hann', nperseg=512, noverlap=256)
