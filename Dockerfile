ARG BASE_IMAGE
FROM ${BASE_IMAGE}

WORKDIR /workspace

# Set environment variables to ensure numpy doesn't try to parallelise
ENV NUMEXPR_NUM_THREADS=1 \
    OMP_NUM_THREADS=1 \
    SHELL=bash

# Install tracing and general tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        strace \
        htop \
        screen && \
    rm -rf /var/lib/apt/lists/*

# Install python requirements
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .
