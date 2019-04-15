if [ ! $(. ./common_dirs.sh) ]; then
  INSTALL_DIR=$HOME
fi

# Install Singularity

# Find distro
DISTRO=$(awk -F= '/^ID=/{print $2}' /etc/os-release)

# Pre-requisites
case "$DISTRO" in
  *cent* | *rhel*)
    sudo yum install -y git \
      openssl-devel libuuid-devel \
      squashfs-tools
    ;;
  *ubuntu*)
    sudo apt-get install -y build-essential \
      libssl-dev uuid-dev libseccomp-dev \
      pkg-config \
      squashfs-tools
esac

# GO
ROOT=/usr/local
GOROOT=$ROOT/go
GOPATH=$INSTALL_DIR/go
export VERSION=1.12.4 OS=linux ARCH=amd64
wget -nc --retry-connrefused --tries=3 --waitretry=5 https://dl.google.com/go/go$VERSION.$OS-$ARCH.tar.gz
sudo tar -C $ROOT -xzvf go$VERSION.$OS-$ARCH.tar.gz
export PATH=${PATH}:${GOROOT}/bin:${GOPATH}/bin
go get -u github.com/golang/dep/cmd/dep

# Singularity
mkdir -p $GOPATH/src/github.com/sylabs
pushd $GOPATH/src/github.com/sylabs
git clone https://github.com/sylabs/singularity.git
cd singularity
./mconfig --prefix=$INSTALL_DIR/singularity
cd builddir
make -j 16 && sudo make install

popd
