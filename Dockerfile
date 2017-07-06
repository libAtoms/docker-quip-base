# Base Python image has most up to date Python parts
# Debian derived
FROM python:2

MAINTAINER Tom Daff "tdd20@cam.ac.uk"

# Build tools and deps for QUIP
RUN apt-get -y update \
    && apt-get upgrade -y \
    && apt-get install -y \
        gfortran \
        liblapack-dev \
        libblas-dev \
        libnetcdf-dev \
        netcdf-bin \
        curl \
        libzmq3

# Custom compilation of OpenBLAS with OpenMP enabled 
# (linear algebra is limited to single core in debs)
# NUM_THREADS must be set otherwise docker hub build
# non-parallel version.
RUN git clone https://github.com/xianyi/OpenBLAS.git /tmp/OpenBLAS
RUN cd /tmp/OpenBLAS/ \
    && make DYNAMIC_ARCH=1 NO_AFFINITY=1 USE_OPENMP=1 NUM_THREADS=32 \
    && make DYNAMIC_ARCH=1 NO_AFFINITY=1 USE_OPENMP=1 NUM_THREADS=32 install

# Make OpenBLAS the default
RUN update-alternatives --install /usr/lib/libblas.so libblas.so /opt/OpenBLAS/lib/libopenblas.so 1000
RUN update-alternatives --install /usr/lib/libblas.so.3 libblas.so.3 /opt/OpenBLAS/lib/libopenblas.so 1000
RUN update-alternatives --install /usr/lib/liblapack.so liblapack.so /opt/OpenBLAS/lib/libopenblas.so 1000
RUN update-alternatives --install /usr/lib/liblapack.so.3 liblapack.so.3 /opt/OpenBLAS/lib/libopenblas.so 1000
RUN ldconfig

# Put any Python libraries here
RUN pip install --upgrade pip
RUN pip install notebook numpy scipy matplotlib ase

# Julia needs to be installed
ENV JULIA_PATH /opt/julia
ENV JULIA_VERSION 0.6.0

# Don't store the intermediate file, pipe into tar
RUN mkdir $JULIA_PATH \
    && cd $JULIA_PATH \
    && curl "https://julialang-s3.julialang.org/bin/linux/x64/${JULIA_VERSION%[.-]*}/julia-${JULIA_VERSION}-linux-x86_64.tar.gz" | tar xz --strip-components 1 

ENV PATH $JULIA_PATH/bin:$PATH

RUN julia -e 'Pkg.add("IJulia")'
RUN julia -e 'Pkg.add("PyCall")'

