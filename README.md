# python-automated-image
Build a python image to be used as a base image

[![build-publish-python-image](https://github.com/devwithkrishna/python-automated-image/actions/workflows/build-python-base-image.yaml/badge.svg)](https://github.com/devwithkrishna/python-automated-image/actions/workflows/build-python-base-image.yaml)

[![build-publish-python-image-trimmed-tag](https://github.com/devwithkrishna/python-automated-image/actions/workflows/build-python-image-trimmed-tag.yaml/badge.svg)](https://github.com/devwithkrishna/python-automated-image/actions/workflows/build-python-image-trimmed-tag.yaml)

# Explanations 

* wget -O python.tar.xz "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz"

```markdown
For example, if PYTHON_VERSION is 3.10.12rc1 (where rc1 denotes a release candidate), ${PYTHON_VERSION%%[a-z]*} would evaluate to 3.10.12. This ensures that only the major and minor numeric parts are used in the URL directory path, as the directory structure on the Python FTP server only includes numeric versions.
```


* docker build --build-arg PYTHON_VERSION=3.11 -t my-python-image .

* PYTHONDONTWRITEBYTECODE=1 --> prevents python from generating .pyc files

# How this works

* we will be inputting python version in the workflow like semvar versions - major.minor.patch versions
* semvar is mandatory
* we will then pull the python code from python ftp site and compile them in run time
* base image used is debian bookworm flavour



* There are 2 workflows 
  * build-python-base-image.yaml
  * build-python-image-trimmed-tag.yaml

As the name suggests the differene between both of them are the tag 

* first one uses the input python version as tag
* second one takes only major and minor version as image tag


* Images are pushed here https://hub.docker.com/r/dockerofkrishnadhas/python/tags