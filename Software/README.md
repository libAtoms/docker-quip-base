quip-base-software
==================

A Docker image build on top of the ``QUIP`` scientific stack that includes
some useful software applications. This has been split from the base
image for applications that take a long time to build. The image is hosted
(and automatically built) on Docker hub as
[libatomsquip/quip-base-software](https://hub.docker.com/r/libatomsquip/quip-base-software/).
You probably don't want to use this image directly, instead look for
one of the QUIP images on https://hub.docker.com/u/libatomsquip/
or use it in your ``FROM`` line. See also:

 - https://github.com/libAtoms/QUIP
 - https://github.com/libAtoms/QUIP/tree/public/docker
 - https://www.libatoms.org

To make or request changes, open a merge request or issue in the
[GitHub repository](https://github.com/libAtoms/docker-quip-base)
where the software layer is found in the ``Software`` subdirectory.

Most dependencies can be added to the base image which is included as
the base layer for building the software
[libatomsquip/quip-base](https://hub.docker.com/r/libatomsquip/quip-base/).

Contents
--------

This image does not contain QUIP, but other useful software applications
that need long compilation times.

Included software:

 - Python 3 including the same scientific stack as Python 2 as a virtualenv
   in ``/opt/python3``
 - Amber (may need to ``source /opt/amber16/amber.sh``), includes mpi version

