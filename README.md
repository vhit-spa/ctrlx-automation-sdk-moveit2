# MoveIt!2 Ctrlx Automation SDK

This repository contains a MoveIt 2 overlay snap build setup for ctrlX CORE, targeting ROS 2 Humble.
It packages the MoveIt 2 runtime, ROS 2 control runtime, and helper scripts into a snap overlay that can be combined with a ctrlX ROS base snap.

## Prerequisites

- A working ROS 2 Humble installation.
- `colcon`, `rosdep`, and `snapcraft` available on the build host.
- The `ctrlx-automation-sdk` repository available for ctrlX SDK support.
- The `ctrlx-automation-sdk-ros2` repository available for ROS 2 integration with ctrlX.
- A valid `rosdep` database: run `sudo rosdep update` if needed.

> The example application repository `ctrlx-ros-moveit-demo` is provided as a reference for how to build an application snap on top of this MoveIt 2 overlay.

## Repository layout

- `build-workspace.sh` - installs ROS dependencies, removes old build artifacts, and runs `colcon build`.
- `build-snap.sh` - builds the workspace and then packages the snap with `snapcraft`.
- `snap/snapcraft.yaml` - defines the MoveIt 2 overlay snap, its parts, plugs, and slots.
- `scripts/setup-env.sh` - helper script used inside the snap to configure ROS and overlay environment variables.
- `src/` - application source path for ROS packages or overlays. In this repository, `src/` is currently empty and the focus is on packaging the overlay/snap.

## Build the overlay snap

 Package the snap overlay:

```bash
./build-snap.sh
```

The resulting snap file will be created in the repository root, such as `moveit2-base-humble_1.0.0_amd64.snap`.

## Build an application snap (example)

For an example application build, see the linked folder `ctrlx-ros-moveit-demo`.
That repository follows the same workflow with its own `build-workspace.sh`, `build-snap.sh`, and `snap/snapcraft.yaml`.

Example steps for the demo application repository:

```bash
cd ~/ctrlx-ros-moveit-demo
source /opt/ros/humble/setup.bash
./build-snap.sh
```

The example repository packages a demo app that launches `usr/bin/run-demo.sh` and uses the `moveit-runtime` content interface from this overlay.

## Notes

- This repository is designed to provide the MoveIt 2 overlay and runtime dependencies required by ctrlX ROS applications.
- Use the `ctrlx-ros-moveit-demo` example as a template for building your own application snap on top of this overlay.
- Ensure the `ctrlx-automation-sdk` provider and `ctrlx-automation-sdk-ros2` integration repositories are available in your development environment before building.
