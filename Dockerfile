# Build the C, C++, Fortran, and Python BMI mappings in a Miniforge (Linux/Ubuntu) image.
FROM condaforge/miniforge3:25.3.0-3

LABEL org.opencontainers.image.authors="Mark Piper <mark.piper@colorado.edu>"
LABEL org.opencontainers.image.url="https://hub.docker.com/r/csdms/bmi"
LABEL org.opencontainers.image.source="https://github.com/csdms/bmi-docker"
LABEL org.opencontainers.image.vendor="CSDMS"

RUN conda install -y \
    make \
    "cmake<4" \
    c-compiler \
    cxx-compiler \
    fortran-compiler \
    pkg-config \
    "numpy<2" \
    vim \
    bmi-c \
    bmi-cxx \
    bmi-fortran \
    bmipy \
    && conda clean --all -y

WORKDIR /opt
