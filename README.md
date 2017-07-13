quip-base
=========

A Docker image with a scientific stack that is used for building ``QUIP``.
The image is hosted (and automatically built) on Docker hub as
[libatomsquip/quip-base](https://hub.docker.com/r/libatomsquip/quip-base/).
You probably don't want to use this image directly, instead look for
one of the QUIP images on https://hub.docker.com/u/libatomsquip/
or use it in your ``FROM`` line. See also:

 - https://github.com/libAtoms/QUIP
 - https://github.com/libAtoms/QUIP/tree/public/docker
 - https://www.libatoms.org

To make or request changes, open a merge request or issue in the
[GitHub repository](https://github.com/libAtoms/docker-quip-base)

Contents
--------

This image does not contain QUIP, but everything needed to build it
plus many tools and codes that we find useful.

Stack contains:

 - Python 2.7 image (based on debian)
 - Build tools (gcc, gfortran)
 - OpenMP compiled verison of OpenBLAS as default math libraries
 - Numpy, SciPy, Matplotlib, ase...
 - Julia in ``/opt/julia`` with IJulia, PyCall, PyPlot, JuLIP...

Data
----

The image includes interatomic potentials in ``/opt/share/potentials``
published on http://www.libatoms.org/Home/DataRepository which has Gaussian
Approximation Potentials for:

 - Tungsten
 - Iron
 - Water
 - Carbon and other bulk semiconductiors (Si, Ge, GaN)

