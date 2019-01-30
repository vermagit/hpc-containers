if [ "$#" -lt 1 ]; then
  echo "Incorrect usage."
  echo "Usage: $0 <app-container-name>"
  exit 1
fi

APP=$1
OPTIONS=$2

if [ "$APP" = "openfoam" ]; then
  # Set environment for application inside container
  set_environment_app()
  {
    source /.singularity.d/env/91-environment.sh
    source $OPENFOAM_DIR/OpenFOAM-v1806/etc/bashrc
  }

  # Set environment for data outside container that app will execute on
  set_environment_data()
  {
    RUN_DIR=$(pwd)
    pushd $RUN_DIR/sloshingTank3D
  }

  set_environment_app
  set_environment_data

  if [ "$OPTIONS" = "serial" ]; then
    foamInstallationTest

    m4 ./system/blockMeshDict.m4 > ./system/blockMeshDict
    source $OPENFOAM_DIR/OpenFOAM-v1806/bin/tools/RunFunctions
    runApplication blockMesh
    cp ./0/alpha.water.orig ./0/alpha.water
    runApplication setFields
    decomposePar -force
  else
    interFoam -parallel
  fi
  popd
fi

if [ "$APP" = "gromacs" ]; then
  # Set environment for application inside container
  set_environment_app()
  {
    source /.singularity.d/env/91-environment.sh
    source $GROMACS_DIR/bin/GMXRC
  }

  # Set environment for data outside container that app will execute on
  set_environment_data()
  {
    RUN_DIR=$(pwd)
    pushd $RUN_DIR/src/gromacs/trajectoryanalysis/tests
  }

  set_environment_app
  set_environment_data

  gmx_mpi mdrun -s freevolume.tpr -nsteps 100
  popd
fi
