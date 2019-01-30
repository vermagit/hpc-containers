# Based on https://github.com/jithinjosepkl/azure-experiments/blob/master/scripts/build_gcc.sh

. ./common_dirs.sh

# Install Development Tools

# Pre-requisites
sudo yum groupinstall -y "Development Tools"
sudo yum install -y m4
sudo yum install -y libgcc.i686
sudo yum install -y glibc-devel.i686

NPROCS=40

# Pre-requisites for GCC
GMP_ROOT=gmp-6.1.0
wget ftp://gcc.gnu.org/pub/gcc/infrastructure/$GMP_ROOT.tar.bz2
tar -xf $GMP_ROOT.tar.bz2
pushd $GMP_ROOT
./configure && make -j $NPROCS && sudo make install
popd

MPFR_ROOT=mpfr-3.1.4
wget ftp://gcc.gnu.org/pub/gcc/infrastructure/$MPFR_ROOT.tar.bz2
tar -xf $MPFR_ROOT.tar.bz2
pushd $MPFR_ROOT
./configure && make -j $NPROCS && sudo make install
popd

MPC_ROOT=mpc-1.0.3
wget ftp://gcc.gnu.org/pub/gcc/infrastructure/$MPC_ROOT.tar.gz
tar -xf $MPC_ROOT.tar.gz
pushd $MPC_ROOT
./configure && make -j $NPROCS && sudo make install
popd

# GCC
GCC_ROOT=gcc-8.2.0
wget https://ftp.gnu.org/gnu/gcc/$GCC_ROOT/$GCC_ROOT.tar.gz
tar -xf $GCC_ROOT.tar.gz
pushd $GCC_ROOT
./configure --disable-multilib
make -j $NPROCS && sudo make install
popd
# Add to path if not already there
[[ ":$LD_LIBRARY_PATH:" != *":/usr/local/lib64:"* ]] && LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/usr/local/lib64"

# CMAKE
CMAKE_ROOT=cmake-3.13.3
wget https://github.com/Kitware/CMake/releases/download/v3.13.3/$CMAKE_ROOT.tar.gz
tar -xf $CMAKE_ROOT.tar.gz
pushd $CMAKE_ROOT
./bootstrap --parallel=$NPROCS
make -j $NPROCS && sudo make install
popd

# NVIDIA CUDA toolkit
DRIVER_URL=https://go.microsoft.com/fwlink/?linkid=874273
CUDA_REPO_RPM=cuda-repo-rhel-x86_64.rpm
wget $DRIVER_URL -O $CUDA_REPO_RPM -nv
sudo rpm -ivh $CUDA_REPO_RPM
sudo yum install -y cuda-minimal-build-10-0
popd
# Add to path if not already there
[[ ":$PATH:" != *":/usr/local/cuda-10.0/bin:"* ]] && PATH="${PATH}:/usr/local/cuda-10.0/bin"


popd