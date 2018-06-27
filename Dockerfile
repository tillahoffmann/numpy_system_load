ARG BASE_IMAGE
FROM ${BASE_IMAGE}

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        strace \
        htop \
        screen && \
    rm -rf /var/lib/apt/lists/*

ENV NUMEXPR_NUM_THREADS=1 \
    OMP_NUM_THREADS=1 \
    SHELL=bash

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .
