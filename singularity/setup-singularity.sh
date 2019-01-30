. ./common_dirs.sh

# Install Singularity

# Pre-requisites
sudo yum install -y git
sudo yum install -y openssl-devel libuuid-devel
sudo yum install -y squashfs-tools

# GO
wget -nc --retry-connrefused --tries=3 --waitretry=5 https://dl.google.com/go/go1.11.4.linux-amd64.tar.gz
tar -xzvf go1.11.4.linux-amd64.tar.gz
GOPATH=$INSTALL_DIR/go
export PATH=${PATH}:${GOPATH}/bin

# Singularity
mkdir -p $GOPATH/src/github.com/sylabs
pushd $GOPATH/src/github.com/sylabs
git clone https://github.com/sylabs/singularity.git
cd singularity
./mconfig --prefix=$INSTALL_DIR/singularity
cd builddir
make -j 16 && make install

popd
