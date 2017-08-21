## Dockerfile to build CASTEP Python interface CasPyTep

Maintainer: James Kermode <j.r.kermode@warwick.ac.uk>

This requires a licensed copy of Castep (free to UK academics). 

Place the CASTEP-17.21.tar.gz source tarball in the working directory before running:

      docker build -t caspytep .

For a demonstration of the capabilities of `CasPyTep`, see the presentation
from the 2017 Castep Advanced Developers Workshop included in the `notebooks/` 
subdirectory.

The included patch file has been submitted to the Castep development repository, so
will be incorporated in future releases.

