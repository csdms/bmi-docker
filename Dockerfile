# Build the C, C++, Fortran, and Python BMI specifications from a Mambaforge (Linux/Ubuntu) image.
FROM condaforge/mambaforge:24.3.0-0

LABEL author="Mark Piper"
LABEL email="mark.piper@colorado.edu"

RUN mamba install -y make cmake c-compiler cxx-compiler fortran-compiler pkg-config "numpy<2"

ENV base_url=https://github.com/csdms

ENV package=bmi-c
ENV version="2.1.2"
ENV prefix=/opt/${package}
RUN git clone --branch v${version} ${base_url}/${package} ${prefix}
WORKDIR ${prefix}/_build
RUN cmake .. -DCMAKE_INSTALL_PREFIX=${CONDA_DIR} && \
    make && \
    make install

ENV package=bmi-cxx
ENV version="2.0.2"
ENV prefix=/opt/${package}
RUN git clone --branch v${version} ${base_url}/${package} ${prefix}
WORKDIR ${prefix}/_build
RUN cmake .. -DCMAKE_INSTALL_PREFIX=${CONDA_DIR} && \
    make && \
    make install

ENV package=bmi-fortran
ENV version="2.0.2"
ENV prefix=/opt/${package}
RUN git clone --branch v${version} ${base_url}/${package} ${prefix}
WORKDIR ${prefix}/_build
RUN cmake .. -DCMAKE_INSTALL_PREFIX=${CONDA_DIR} && \
    make && \
    make install

ENV package=bmi-python
ENV version="2.0.1"
ENV prefix=/opt/${package}
RUN git clone --branch v${version} ${base_url}/${package} ${prefix}
WORKDIR ${prefix}
RUN pip install .

WORKDIR /opt
