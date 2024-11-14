# python-automated-image
Build a python image to be used as a base image


# Explanations 

* wget -O python.tar.xz "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz"

```markdown
For example, if PYTHON_VERSION is 3.10.12rc1 (where rc1 denotes a release candidate), ${PYTHON_VERSION%%[a-z]*} would evaluate to 3.10.12. This ensures that only the major and minor numeric parts are used in the URL directory path, as the directory structure on the Python FTP server only includes numeric versions.
```


* docker build --build-arg PYTHON_VERSION=3.11 -t my-python-image .

* PYTHONDONTWRITEBYTECODE=1 --> prevents python from generating .pyc files
