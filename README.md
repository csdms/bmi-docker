# bmi-docker

The [Basic Model Interface](https://bmi.csdms.io) (BMI) mappings and examples for C, C++, Fortran, and Python, Dockerized.

The image built from these instructions can be used as a base for building models that expose a BMI in these languages,
or for inter-language model coupling.

## Build the image

Build an image locally with:
```
docker build --tag bmi .
```
The image is built on the [condaforge/miniforge3](https://hub.docker.com/r/condaforge/miniforge3/) base image.
The OS is Linux/Ubuntu.
`conda`, as well as the BMI language mappings and examples, are installed in `CONDA_DIR=/opt/conda`.
The *base* environment is activated.

## Run a container

Run a container from this image interactively:
```
docker run -it --rm bmi
```
This starts a bash shell in the container where the language mappings and examples can be accessed.

### C example

Run the program `run_bmiheatc`
from the [BMI C example](https://github.com/csdms/bmi-example-c)
with a configuration file:
```bash
cd /tmp
echo "1.5, 8.0, 6, 5" > config.txt
run_bmiheatc config.txt
```
View the program's output with:
```bash
cat bmiheatc.out
```

### C++ example

Run the program `run_bmiheatcxx`
from the [BMI C++ example](https://github.com/csdms/bmi-example-cxx)
with a configuration file:
```bash
cd /tmp
echo "1.5, 8.0, 6, 5" > config.txt
run_bmiheatcxx config.txt
```
View the program's output with:
```bash
cat bmiheatcxx.out
```

### Fortran example

Run the program `run_bmiheatf`
from the [BMI Fortran example](https://github.com/csdms/bmi-example-fortran)
with a configuration file:
```bash
cd /tmp
echo "1.5, 8.0, 6, 5" > config.txt
run_bmiheatf config.txt
```
View the program's output with:
```bash
cat bmiheatf.out
```

### Python example

Start a Python session to run the *heat* model through its BMI.
```python
>>> from heat import BmiHeat
>>> x = BmiHeat()
>>> x.get_component_name()
'The 2D Heat Equation'
```

The Python BMI example includes a set of [example notebooks](https://github.com/csdms/bmi-example-python/tree/master/examples).
Run them through a container.
```bash
docker run -it --port 8888:8888 bmi-example-python /bin/bash -c "\
    conda install jupyter -y --quiet && \
    jupyter notebook \
    --notebook-dir=/opt/bmi-example-python/examples \
    --ip='*' --port=8888 \
    --no-browser --allow-root"
```
This is a little tricky, but
examine the output of the Jupyter server after it starts;
it will include an URL from *localhost* that includes a security token.
Copy/paste this URL into a browser to view and run the example notebooks.

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
