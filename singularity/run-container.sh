#!/usr/bin/env bash

# Example script to execute applications within containers on data outside containers

if [ "$#" -ne 1 ]; then
  echo "Incorrect usage."
  echo "Usage: $0 <app-container-name>"
  exit 1
fi

# Setup environment

# OpenMPI example

# Set PKEY
PKEY0=$(cat /sys/class/infiniband/mlx5_0/ports/1/pkeys/0)
PKEY1=$(cat /sys/class/infiniband/mlx5_0/ports/1/pkeys/1)
if [ $(($PKEY0 - $PKEY1)) -gt 0 ]; then
    IB_PKEY=$PKEY0
else
    IB_PKEY=$PKEY1
fi
UCX_PKEY=$(printf '0x%04x' "$(( $IB_PKEY & 0x0FFF ))")
#UCX_PKEY=${IB_PKEY/x?/x0} # clear MSB

# The name of the container is passed as argument
APP=$1

# Select App to run inside the container
SING_EXEC="singularity exec ${APP}.sif bash ./run-app.sh ${APP}"

# OpenFOAM example: Invoke with run-container.sh openfoam
if [ "$APP" = "openfoam" ]; then
  ${SING_EXEC} serial
  mpirun --allow-run-as-root --hostfile ./hostfile -np 30 --map-by numa --bind-to core --report-bindings -mca pml ucx -mca btl self,vader -x UCX_TLS=rc -x UCX_NET_DEVICES=mlx5_0:1 -x UCX_IB_PKEY=$UCX_PKEY ${SING_EXEC} parallel
fi

# Gromacs example: Invoke with run-container.sh gromacs
if [ "$APP" = "gromacs" ]; then
  mpirun --allow-run-as-root --hostfile ./hostfile -np 30 --map-by numa --bind-to core --report-bindings -mca pml ucx -mca btl self,vader -x UCX_TLS=rc -x UCX_NET_DEVICES=mlx5_0:1 -x UCX_IB_PKEY=$UCX_PKEY ${SING_EXEC}
fi
