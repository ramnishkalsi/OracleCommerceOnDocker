#!/bin/sh

set -o pipefail

FILE=oegs-11.1.0

IMAGE=ramnishkalsi/oegs
VERSION=0.1

docker build -t ${IMAGE}:${VERSION} $FILE | tee build.log || exit 1
ID=$(tail -1 build.log | awk '{print $3;}')
