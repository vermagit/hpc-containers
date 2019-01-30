. ./common_dirs.sh

# Make singularity available to sudo
#sudo cp $INSTALL_DIR/singularity/bin/singularity /usr/bin/


#-----------------------------------------------------------
# Examples

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
# 2 methods provided as examples here

# build <destination container> from sandbox <source container>
build_from_sandbox()
{
  dest=$1
  src=$2
  options=$3
  sudo cp -r $src/ $dest/
  sudo singularity build --update $options $dest/ $dest.def
  sudo singularity build $dest.sif $dest/
  singularity push $dest.sif library://verma/default/layer:$dest
}


#-----------------------------------------------------------
# IB container
#build_from_sandbox "ib" "centos"

#-----------------------------------------------------------
# Next layer: MPI containers
#build_from_sandbox "mpich" "ib"
#build_from_sandbox "mvapich" "ib"
#build_from_sandbox "openmpi" "ib"

#-----------------------------------------------------------
# Next layer: Apps
#build_from_sandbox "openfoam" "openmpi" "-T"
#build_from_sandbox "petsc" "openmpi"
#build_from_sandbox "nas" "openmpi"


# build <destination container> from sandbox <source container>
build_from_image()
{
  dest=$1
  options=$2
  sudo singularity build --force $options $dest.sif $dest.def
  singularity push $dest.sif library://verma/default/layer:$dest
}

#-----------------------------------------------------------
# IB container
#build_from_image "ib"

#-----------------------------------------------------------
# Next layer: MPI containers
#build_from_image "mpich"
#build_from_image "mvapich"
#build_from_image "openmpi"

#-----------------------------------------------------------
# Next layer: Apps
#build_from_image "openfoam" "-T"
#build_from_image "petsc"
#build_from_image "nas"
#build_from_image "opm-ompi-bin" "-T"
#build_from_image "gromacs" "-T"


popd # from common_dirs.sh->$INSTALL_DIR
