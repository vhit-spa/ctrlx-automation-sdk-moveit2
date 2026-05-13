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
source $ROS_BASE/opt/ros/humble/setup.bash

# Overlay SECOND
source $PROVIDER_SNAP/local_setup.bash

# Consumer Python
if [ -d "$SNAP/opt/ros/humble" ]; then
    export PYTHONPATH=$SNAP/opt/ros/humble/lib/python3.10/site-packages:$PYTHONPATH
    export PYTHONPATH=$SNAP/opt/ros/humble/local/lib/python3.10/dist-packages:$PYTHONPATH

    export LD_LIBRARY_PATH=$SNAP/opt/ros/humble/lib:$LD_LIBRARY_PATH
    export LD_LIBRARY_PATH=$SNAP/opt/ros/humble/lib/$TRIPLET:$LD_LIBRARY_PATH
fi

# Python
export PYTHONPATH=$ROS_BASE/lib/python3.10/site-packages:$PYTHONPATH
export PYTHONPATH=$PROVIDER_SNAP/opt/ros/humble/lib/python3.10/site-packages:$PYTHONPATH
export PYTHONPATH=$PROVIDER_SNAP/opt/ros/humble/local/lib/python3.10/dist-packages:$PYTHONPATH

# Libraries
export LD_LIBRARY_PATH=$PROVIDER_SNAP/opt/ros/humble/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$PROVIDER_SNAP/opt/ros/humble/lib/$TRIPLET:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$PROVIDER_SNAP/opt/ros/humble/lib/controller_manager:$LD_LIBRARY_PATH

export LD_LIBRARY_PATH=$ROS_BASE/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$ROS_BASE/lib/$TRIPLET:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$ROS_BASE/usr/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$ROS_BASE/usr/lib/$TRIPLET:$LD_LIBRARY_PATH

export LD_LIBRARY_PATH=$PROVIDER_SNAP/opt/ros/humble/opt/rviz_ogre_vendor/lib:$LD_LIBRARY_PATH

# Consumer overlay FIRST (if present)
if [ -d "$SNAP/opt/ros/humble" ]; then
    export AMENT_PREFIX_PATH=$AMENT_PREFIX_PATH:$SNAP/opt/ros/humble
fi

# Overlay
export AMENT_PREFIX_PATH=$AMENT_PREFIX_PATH:$PROVIDER_SNAP/opt/ros/humble