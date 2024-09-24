# bmi-docker

The [Basic Model Interface](https://bmi.readthedocs.io) (BMI) specifications for C, C++, Fortran, and Python, Dockerized.

The image built from these instructions can be used as a base for building models that expose a BMI in these languages,
or for inter-language model coupling.

## Build the image

Build an image locally with:
```
docker build --tag bmi .
```
The image is built on the [condaforge/mambaforge](https://hub.docker.com/r/condaforge/mambaforge) base image.
The OS is Linux/Ubuntu.
`conda` and `mamba`, as well as the BMI specifications, are installed in `CONDA_DIR=/opt/conda`.
The *base* environment is activated.

## Run a container

Run a container from this image interactively:
```
docker run -it bmi
```
This starts a bash shell in the container, where the specifications can be accessed.

## Developer notes

A versioned, multiplatform image built from this repository is hosted on Docker Hub
at [csdms/bmi](https://hub.docker.com/repository/docker/csdms/bmi/).
This image is automatically built and pushed to Docker Hub
with the [release](./.github/workflows/release.yml) CI workflow.
The workflow is only run when the repository is tagged.
To manually build and push an update, run:
```
docker buildx build --platform linux/amd64,linux/arm64 -t csdms/bmi:latest --push .
```
A user can pull this image from Docker Hub with:
```
docker pull csdms/bmi
```
optionally with the `latest` tag or with a version tag.

## What is the Basic Model Interface?

The Basic Model Interface (BMI) is a set of functions for querying, modifying, running, and coupling models.
Learn more at https://bmi.readthedocs.io/.

## Acknowledgment

This work is supported by the U.S. National Science Foundation under Award No. [2103878](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2103878), *Frameworks: Collaborative Research: Integrative Cyberinfrastructure for Next-Generation Modeling Science*.
