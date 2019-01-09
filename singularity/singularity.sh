. ./common_dirs.sh

# Install Singularity

# Pre-requisites
sudo yum install -y git
sudo yum install -y openssl-devel libuuid-devel

# GO
wget -nc --retry-connrefused --tries=3 --waitretry=5 https://dl.google.com/go/go1.11.4.linux-amd64.tar.gz
tar -xzvf go1.11.4.linux-amd64.tar.gz
GOPATH=$INSTALL_DIR/go
export PATH=${PATH}:${GOPATH}/bin

# Singularity
pushd $GOPATH
mkdir -p $GOPATH/src/github.com/sylabs
cd $GOPATH/src/github.com/sylabs
git clone https://github.com/sylabs/singularity.git
pushd singularity
./mconfig --prefix=$INSTALL_DIR/singularity
pushd ./builddir
make -j 16 && make install
popd +1

popd

sudo yum install -y squashfs-tools
