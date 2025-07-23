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
    && conda clean --all -y

ENV base_url=https://github.com/csdms

ENV project=bmi-c
ENV version="2.1.2"
ENV prefix=/opt/${project}
RUN git clone --branch v${version} ${base_url}/${project} ${prefix}
WORKDIR ${prefix}/_build
RUN cmake .. -DCMAKE_INSTALL_PREFIX=${CONDA_DIR} && \
    make && \
    make install && \
    make clean

ENV project=bmi-cxx
ENV version="2.0.2"
ENV prefix=/opt/${project}
RUN git clone --branch v${version} ${base_url}/${project} ${prefix}
WORKDIR ${prefix}/_build
RUN cmake .. -DCMAKE_INSTALL_PREFIX=${CONDA_DIR} && \
    make && \
    make install && \
    make clean

ENV project=bmi-fortran
ENV version="2.0.3"
ENV prefix=/opt/${project}
RUN git clone --branch v${version} ${base_url}/${project} ${prefix}
WORKDIR ${prefix}/_build
RUN cmake .. -DCMAKE_INSTALL_PREFIX=${CONDA_DIR} && \
    make && \
    make install && \
    make clean

ENV project=bmi-python
ENV version="2.0.1"
ENV prefix=/opt/${project}
RUN git clone --branch v${version} ${base_url}/${project} ${prefix}
WORKDIR ${prefix}
RUN pip install . && \
    pip cache purge

WORKDIR /opt
