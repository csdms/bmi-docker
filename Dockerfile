# Build the C, C++, Fortran, and Python BMI mappings and examples in a Miniforge (Linux/Ubuntu) image.
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
    numpy \
    vim \
    bmi-c \
    bmi-cxx \
    bmi-fortran \
    bmipy \
    && conda clean --all -y

ENV base_url=https://github.com/csdms

ENV project=bmi-example-c
ENV version="2.0.3"
ENV prefix=/opt/${project}
RUN git clone --branch v${version} --depth 1 ${base_url}/${project} ${prefix}
WORKDIR ${prefix}/_build
RUN cmake .. -DCMAKE_INSTALL_PREFIX=${CONDA_DIR} && \
    make && \
    ctest -V && \
    make install && \
    make clean

ENV project=bmi-example-cxx
ENV version="2.1.3"
ENV prefix=/opt/${project}
RUN git clone --branch v${version} --depth 1 ${base_url}/${project} ${prefix}
WORKDIR ${prefix}/_build
RUN cmake .. -DCMAKE_INSTALL_PREFIX=${CONDA_DIR} && \
    make && \
    ctest -V && \
    make install && \
    make clean

ENV project=bmi-example-fortran
ENV version="2.1.4"
ENV prefix=/opt/${project}
RUN git clone --branch v${version} --depth 1 ${base_url}/${project} ${prefix}
WORKDIR ${prefix}/_build
RUN cmake .. -DCMAKE_INSTALL_PREFIX=${CONDA_DIR} && \
    make && \
    ctest -V && \
    make install && \
    make clean

ENV project=bmi-example-python
ENV version="2.1.2"
ENV prefix=/opt/${project}
RUN git clone --branch v${version} --depth 1 ${base_url}/${project} ${prefix}
WORKDIR ${prefix}
RUN pip install . && \
    pip cache purge

WORKDIR /opt
