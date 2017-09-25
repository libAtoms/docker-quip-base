# Software applications
# Split from base image to keep under the 2 hr build
# limit on docker hub.

# Base QUIP image has build dependencies
FROM libatomsquip/quip-base

MAINTAINER Tom Daff "tdd20@cam.ac.uk"

##############
## Python 3 ##
##############

# Put Python 3 packages in a virtualenv
# include `py3` command as a quick alias
# to activate
RUN virtualenv -p python3 /opt/python3
RUN echo "alias py3='source /opt/python3/bin/activate'" > /etc/profile.d/00-py3.sh

ENV PYTHON3 /opt/python3/bin/python
ENV PIP3 /opt/python3/bin/pip

RUN $PIP3 install --upgrade pip
RUN $PIP3 install --no-cache-dir jupyter numpy scipy matplotlib ase pyamg \
                                 imolecule sphinx spglib
# Requires numpy to install
RUN $PIP3 install --no-cache-dir gpaw

RUN $PIP3 install git+https://github.com/libAtoms/matscipy.git

RUN $PIP3 install --global-option=build_ext --global-option="-L/opt/OpenBLAS/lib" atomistica


# AmberTools (no Amber)

ENV AMBERHOME /opt/amber16/

# Never write the tests to disk (1GB) and remove src (500MB) after compilation

RUN mkdir -p ${AMBERHOME} \
    && cd ${AMBERHOME} \
    && curl "http://ambermd.org/cgi-bin/AmberTools17-get.pl?Name=quipbot&Institution=NA&City=NA&State=NA&Country=NA&OS=linux-64" \
        | tar xj --exclude='*/test/*' --strip-components 1 \
    && ./update_amber --show-applied-patches \
    && ./update_amber --update \
    && ./update_amber --show-applied-patches \
    && ./configure --with-python `which python` --python-install global -noX11 gnu \
    && make install \
    && ./configure --with-python `which python` --python-install global -noX11 -mpi gnu \
    && make install \
    && rm -rf ${AMBERHOME}/test ${AMBERHOME}/AmberTools

ENV PATH ${AMBERHOME}/bin:${PATH}


