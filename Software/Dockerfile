# Software applications
# Split from base image to keep under the 2 hr build
# limit on docker hub.

# Base QUIP image has build dependencies
FROM libatomsquip/quip-base

MAINTAINER Tom Daff "tdd20@cam.ac.uk"

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


