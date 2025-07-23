# Build the C, C++, Fortran, and Python BMI specifications in a Miniforge (Linux/Ubuntu) image.
FROM condaforge/miniforge3:25.3.0-3

LABEL author="Mark Piper"
LABEL email="mark.piper@colorado.edu"

RUN conda install -y \
    make \
    cmake \
    c-compiler \
    cxx-compiler \
    fortran-compiler \
    pkg-config \
    "numpy<2" \
    vim \
    && conda clean --all -y

ENV base_url=https://github.com/csdms

ENV package=bmi-c
ENV version="2.1.2"
ENV prefix=/opt/${package}
RUN git clone --branch v${version} ${base_url}/${package} ${prefix}
WORKDIR ${prefix}/_build
RUN cmake .. -DCMAKE_INSTALL_PREFIX=${CONDA_DIR} && \
    make && \
    make install && \
    make clean

ENV package=bmi-cxx
ENV version="2.0.2"
ENV prefix=/opt/${package}
RUN git clone --branch v${version} ${base_url}/${package} ${prefix}
WORKDIR ${prefix}/_build
RUN cmake .. -DCMAKE_INSTALL_PREFIX=${CONDA_DIR} && \
    make && \
    make install && \
    make clean

ENV package=bmi-fortran
ENV version="2.0.3"
ENV prefix=/opt/${package}
RUN git clone --branch v${version} ${base_url}/${package} ${prefix}
WORKDIR ${prefix}/_build
RUN cmake .. -DCMAKE_INSTALL_PREFIX=${CONDA_DIR} && \
    make && \
    make install && \
    make clean

ENV package=bmi-python
ENV version="2.0.1"
ENV prefix=/opt/${package}
RUN git clone --branch v${version} ${base_url}/${package} ${prefix}
WORKDIR ${prefix}
RUN pip install . && \
    pip cache purge

WORKDIR /opt
