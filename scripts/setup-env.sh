#!/bin/bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
PROVIDER_SNAP=$(cd "$SCRIPT_DIR/../.." && pwd)

export TRIPLET=$(uname -m)-linux-gnu

# If consumer already mounted ros-base use that
if [ -d "$SNAP/rosruntime" ]; then
    export ROS_BASE=$SNAP/rosruntime
else
    export ROS_BASE=$PROVIDER_SNAP/rosruntime
fi

# Provider FIRST
source $ROS_BASE/opt/ros/jazzy/setup.bash

# Overlay SECOND
source $PROVIDER_SNAP/local_setup.bash

# Consumer Python
if [ -d "$SNAP/opt/ros/jazzy" ]; then
    export PYTHONPATH=$SNAP/opt/ros/jazzy/lib/python3.10/site-packages:$PYTHONPATH
    export PYTHONPATH=$SNAP/opt/ros/jazzy/local/lib/python3.10/dist-packages:$PYTHONPATH
    export PYTHONPATH=$SNAP/usr/lib/python3/dist-packages:$PYTHONPATH

    export LD_LIBRARY_PATH=$SNAP/opt/ros/jazzy/lib:$LD_LIBRARY_PATH
    export LD_LIBRARY_PATH=$SNAP/opt/ros/jazzy/lib/$TRIPLET:$LD_LIBRARY_PATH
fi

# Python
export PYTHONPATH=$ROS_BASE/lib/python3.10/site-packages:$PYTHONPATH
export PYTHONPATH=$ROS_BASE/usr/lib/python3/dist-packages:$PYTHONPATH

export PYTHONPATH=$PROVIDER_SNAP/opt/ros/jazzy/lib/python3.10/site-packages:$PYTHONPATH
export PYTHONPATH=$PROVIDER_SNAP/opt/ros/jazzy/local/lib/python3.10/dist-packages:$PYTHONPATH
export PYTHONPATH=$PROVIDER_SNAP/usr/lib/python3/dist-packages:$PYTHONPATH

# Provider ROS libs
export LD_LIBRARY_PATH=$PROVIDER_SNAP/opt/ros/jazzy/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$PROVIDER_SNAP/opt/ros/jazzy/lib/$TRIPLET:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$PROVIDER_SNAP/opt/ros/jazzy/lib/controller_manager:$LD_LIBRARY_PATH

# RViz Ogre vendor
# export LD_LIBRARY_PATH=$PROVIDER_SNAP/opt/ros/jazzy/opt/rviz_ogre_vendor/lib:$LD_LIBRARY_PATH

# Provider system libs
export LD_LIBRARY_PATH=$PROVIDER_SNAP/usr/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$PROVIDER_SNAP/usr/lib/$TRIPLET:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$PROVIDER_SNAP/usr/lib/$TRIPLET/blas:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$PROVIDER_SNAP/usr/lib/$TRIPLET/lapack:$LD_LIBRARY_PATH

# Base provider libs
export LD_LIBRARY_PATH=$ROS_BASE/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$ROS_BASE/lib/$TRIPLET:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$ROS_BASE/usr/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$ROS_BASE/usr/lib/$TRIPLET:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$ROS_BASE/usr/lib/$TRIPLET/blas:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$ROS_BASE/usr/lib/$TRIPLET/lapack:$LD_LIBRARY_PATH


# Consumer overlay FIRST (if present)
if [ -d "$SNAP/opt/ros/jazzy" ]; then
    export AMENT_PREFIX_PATH=$AMENT_PREFIX_PATH:$SNAP/opt/ros/jazzy
fi

# Overlay
export AMENT_PREFIX_PATH=$AMENT_PREFIX_PATH:$PROVIDER_SNAP/opt/ros/jazzy