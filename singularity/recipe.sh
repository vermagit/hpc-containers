. ./common_dirs.sh

# Make singularity available to sudo
#sudo cp $INSTALL_DIR/singularity/bin/singularity /usr/bin/


#-----------------------------------------------------------
# Base centOS image from definition file
#sudo singularity build centOS.sif centos.def

# Writable centOS/ 'sandbox'
#sudo singularity build --sandbox centOS/ centOS.sif

# Push to library
#singularity push centOS.sif library://verma/default/layer:centos

# Pull from library and build sandbox centOS/
#sudo singularity build --sandbox centOS/ library://verma/default/layer:centos


#-----------------------------------------------------------
# Start inhering and 'layering'/'stacking' containers on top
# IB container

OBJ=ib
#sudo cp -r centOS/ $OBJ/
#sudo singularity build --update $OBJ/ $OBJ.def
#sudo singularity build $OBJ.sif $OBJ/
#singularity push $OBJ.sif library://verma/default/layer:$OBJ


#-----------------------------------------------------------
# Next layer: MPI containers

OBJ=openmpi
#sudo cp -r ib/ $OBJ/
#sudo singularity build --update $OBJ/ $OBJ.def
#sudo singularity build $OBJ.sif $OBJ/
#singularity push $OBJ.sif library://verma/default/layer:$OBJ

OBJ=mvapich
#sudo cp -r ib/ $OBJ/
#sudo singularity build --update $OBJ/ $OBJ-virt.def
#sudo singularity build $OBJ.sif $OBJ/
#singularity push $OBJ.sif library://verma/default/layer:$OBJ


#-----------------------------------------------------------
# Next layer: Apps

OBJ=openfoam
#sudo cp -r openmpi/ $OBJ/
#sudo singularity build --update $OBJ/ $OBJ.def
#sudo singularity build $OBJ.sif $OBJ/
#singularity push $OBJ.sif library://verma/default/layer:$OBJ


popd # from common_dirs.sh->$INSTALL_DIR
