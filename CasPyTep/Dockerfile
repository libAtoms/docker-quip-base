FROM libatomsquip/quip-nogap

MAINTAINER James Kermode <j.r.kermode@warwick.ac.uk>

# add some packages
RUN printf "deb http://archive.debian.org/debian/ jessie main\ndeb-src http://archive.debian.org/debian/ jessie main\ndeb http://security.debian.org jessie/updates main\ndeb-src http://security.debian.org jessie/updates main" > /etc/apt/sources.list

RUN apt-get -y update \
    && apt-get upgrade -y \
    && apt-get install -y \
        cmake

# build spglib 1.9.9
RUN cd /opt && \
    curl -L "https://github.com/atztogo/spglib/archive/v1.9.9.tar.gz" | tar xz && \
    cd spglib-1.9.9 && \
    mkdir _build && cd _build && \
    CFLAGS=-fPIC cmake .. && \
    make && \
    mv libsymspg.a libsymspg-static.a

# install f90wrap v0.1.5
RUN pip install git+https://github.com/jameskermode/f90wrap@v0.1.5

# specify base Castep version
ENV CASTEP_VERSION 17.21

# copy in CASTEP source tarball and patch
COPY CASTEP-${CASTEP_VERSION}.tar.gz /opt
COPY CasPyTep.patch /opt

# build a serial version of CASTEP
RUN cd /opt && \
    tar xzf CASTEP-${CASTEP_VERSION}.tar.gz && \
    cd CASTEP-${CASTEP_VERSION} && \
    patch -p 1 < ../CasPyTep.patch && \
    make MATHLIBS=openblas MATHLIBDIR=/opt/OpenBLAS/lib SPGLIB=system EXTRA_LIBS="-L/opt/spglib-1.9.9/_build -lsymspg-static"

# now build the CASTEP Python bindings
RUN cd /opt/CASTEP-${CASTEP_VERSION} && \
     make MATHLIBS=openblas MATHLIBDIR=/opt/OpenBLAS/lib SPGLIB=system EXTRA_LIBS="-L/opt/spglib-1.9.9/_build -lsymspg-static" python && \
     make MATHLIBS=openblas MATHLIBDIR=/opt/OpenBLAS/lib SPGLIB=system EXTRA_LIBS="-L/opt/spglib-1.9.9/_build -lsymspg-static" python-install

# side-load latest caspytep source + examples to avoid slow rebuilds
# COPY CASTEP-modifications/Source/Python/caspytep /usr/local/lib/python2.7/site-packages/caspytep
# COPY CASTEP-modifications/Examples/Python /opt/CASTEP-${CASTEP_VERSION}/Examples/Python

# install CASTEP serial binary and generate castep_commands.py
ENV CASTEP_COMMAND /usr/local/bin/castep.serial
RUN cp /opt/CASTEP-${CASTEP_VERSION}/obj/linux_x86_64_gfortran4.9/castep.serial /usr/local/bin && \
    python -c 'from ase.calculators.castep import Castep; Castep()' && \
    mv castep_keywords.py /usr/local/lib/python2.7/site-packages/ase/calculators

# remove QUIP example notebook and add the example notebooks directory
RUN rm /root/demo.ipynb
COPY notebooks /root/notebooks

# install RISE jupyter plugin for slideshows
RUN pip install RISE && \
  jupyter-nbextension install rise --py --sys-prefix && \
  jupyter-nbextension enable rise --py --sys-prefix
