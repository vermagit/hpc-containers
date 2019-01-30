# Singularity Definitions
This directory contains Singularity definition files to build images which are available at the [Singularity Library](https://cloud.sylabs.io/library/verma).

The definition files have been kept minimal. Please review the definition files and modify accordingly for other use cases. These also contain examples for running the containers, either within the %test or %runscript sections.

## Recipes
The hierarchy of the 'layered' approach is as follows, with each successive layer re-using and building upon the previous layer.

1. [Operating System](#OS)
2. [Drivers](#drivers)
3. [MPI](#MPI)
4. [Applications](#apps)

### <a name="OS"></a>Operating System
[CentOS](./centos.def): Base OS container.

### <a name="drivers"></a>Drivers
[Mellanox OFED for InfiniBand](./ib.def): Container with Mellanox OFED, UCX and HPC-X for best performance over InfiniBand.

### <a name="MPI"></a>MPI
[MPICH](./mpich.def): Container with MPICH, configured with UCX, HPC-X.

[MVAPICH](./mvapich.def): Container with MVAPICH.

[OpenMPI](./openmpi.def): Container with OpenMPI, configured with UCX.

### <a name="apps"></a>Applications
[OpenFOAM](./openfoam.def): Container with complete [OpenFOAM](https://www.openfoam.com/releases/openfoam-v1806/) (and ThirdParty utilities) installation.

[PETSc](./petsc.def): Container with [PETSc](https://www.mcs.anl.gov/petsc/).

[NAS](./nas.def): Container with [NAS Benchmarks](https://www.nas.nasa.gov/publications/npb.html).

[OPM](./opm-ompi-bin.def): Container with Open Porous Media reservoir simulator ([OPM](https://opm-project.org/)). OPM simulators - OpenMPI binary package.

[Gromacs](./gromacs.def): Container with [Gromacs](http://www.gromacs.org/) molecular dynamics simulation package, built with OpenMPI 4 and CUDA 10.0.
