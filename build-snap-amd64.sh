#!/bin/bash

set -e

snapcraft clean
snapcraft pack --build-for=amd64 --verbosity=verbose
