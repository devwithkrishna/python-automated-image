# Using Debian Bookworm (v12) as the base image
FROM debian:bookworm

# Accept Python version as a build argument
ARG PYTHON_VERSION

# Ensure local Python is preferred over the distribution's Python
ENV PATH="/usr/local/bin:$PATH"

# Applications in the environment can handle UTF-8 encoded characters correctly
ENV LANG="C.UTF-8"

# Install runtime dependencies
RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        libbluetooth-dev \
        ca-certificates \
        curl \
        wget \
        git \
        netbase \
        uuid-dev \
        dpkg-dev \
        gcc \
        gnupg \
		libbluetooth-dev \
        libbz2-dev \
        libc6-dev \
        libdb-dev \
        libffi-dev \
        libgdbm-dev \
        liblzma-dev \
        libncursesw5-dev \
        libreadline-dev \
        libsqlite3-dev \
        libssl-dev \
        make \
        tk-dev \
		uuid-dev \
        xz-utils \
        zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Set the Python version as an environment variable for later use
ENV PYTHON_VERSION=${PYTHON_VERSION}

# Build and compile Python
RUN set -eux; \
    wget -O python.tar.xz "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz"; \
    mkdir -p /usr/src/python; \
    tar --extract --directory /usr/src/python --strip-components=1 --file python.tar.xz; \
    rm python.tar.xz; \
    cd /usr/src/python; \
    gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)"; \
    ./configure \
        --build="$gnuArch" \
        --enable-loadable-sqlite-extensions \
        --enable-optimizations \
        --enable-option-checking=fatal \
        --enable-shared \
        --with-lto \
        --with-ensurepip; \
    nproc="$(nproc)"; \
    make -j "$nproc"; \
    make install; \
    ldconfig; \
	export PYTHONDONTWRITEBYTECODE=1; \
    python3 --version; \
    pip3 install \
        --disable-pip-version-check \
        --no-cache-dir \
        --no-compile \
        'setuptools==68.0.0' \
        wheel; \
    pip3 --version

# Create symlinks for common Python utilities
RUN set -eux; \
    for src in idle3 pip3 pydoc3 python3 python3-config; do \
        dst="$(echo "$src" | tr -d 3)"; \
        [ -s "/usr/local/bin/$src" ]; \
        [ ! -e "/usr/local/bin/$dst" ]; \
        ln -svT "$src" "/usr/local/bin/$dst"; \
    done

# Set the default command to Python3
CMD ["python3"]
