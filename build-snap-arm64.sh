#!/bin/bash

set -e

snapcraft clean --destructive-mode

snapcraft pack --build-for=arm64 --verbosity=verbose --destructive-mode
