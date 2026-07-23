#!/bin/bash

set -e

snapcraft clean --destructive-mode

snapcraft pack --build-for=amd64 --verbosity=verbose --destructive-mode
