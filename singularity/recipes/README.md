# Singularity Definitions
This directory contains Singularity definition files to build images which are available at the [Singularity Library](https://cloud.sylabs.io/library/verma).

The definition files have been kept minimal. Please review the definition files and modify accordingly for other use cases.

## Recipes
The hierarchy of the 'layered' approach is as follows, with each successive layer re-using and building upon the previous layer.

1. [Operating System](#OS)
2. [Drivers](#drivers)
3. [MPI](#MPI)
4. [Applications](#apps)

### <a name="OS"></a>Operating System
[CentOS](./centos.def): Base OS container.

### <a name="drivers"></a>Drivers
[Mellanox OFED for InfiniBand](./ib.def): Container with Mellanox OFED and UCX for best performance over InfiniBand.

### <a name="MPI"></a>MPI
[MVAPICH](./mvapich-virt.def): Container with MVAPICH-Virt.

[OpenMPI](./openmpi.def): Container with OpenMPI and UCX.

### <a name="apps"></a>Applications
[OpenFOAM](./openfoam.def): Container with complete OpenFOAM (and ThirdParty utilities) installation.

OPM: Coming soon ...

NAS Benchmarks: Coming soon ...