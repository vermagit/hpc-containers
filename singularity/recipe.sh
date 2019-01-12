. ./common_dirs.sh

# Make singularity available to sudo
#sudo cp $INSTALL_DIR/singularity/bin/singularity /usr/bin/


#-----------------------------------------------------------
# Base centOS image from definition file
#sudo singularity build centos.sif centos.def

# Writable centos/ 'sandbox'
#sudo singularity build --sandbox centos/ centos.sif

# Push to library
#singularity push centos.sif library://verma/default/layer:centos

# Pull from library and build sandbox centos/
#sudo singularity build --sandbox centos/ library://verma/default/layer:centos


#-----------------------------------------------------------
# Start inheriting and 'layering'/'stacking' containers on top
# build <destination container> "from" <source container>

build_container()
{
  dest=$1
  src=$2
  sudo cp -r $src/ $dest/
  sudo singularity build --update $dest/ $dest.def
  sudo singularity build $dest.sif $dest/
  singularity push $dest.sif library://verma/default/layer:$dest
}


#-----------------------------------------------------------
# IB container

#build_container "ib" "centos"


#-----------------------------------------------------------
# Next layer: MPI containers

#build_container "openmpi" "ib"

#build_container "mvapich" "ib"


#-----------------------------------------------------------
# Next layer: Apps

#build_container "openfoam" "openmpi"


popd # from common_dirs.sh->$INSTALL_DIR
