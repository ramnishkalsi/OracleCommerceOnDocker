#!/bin/sh

set -o pipefail

FILE=oegs-11.1.0
IMAGE=ramnishkalsi/oegs
VERSION=0.1


BUILD_LOG_FILE=/tmp/build.log
mv $BUILD_LOG_FILE $BUILD_LOG_FILE.`date +%s`

docker build -t ${IMAGE}:${VERSION} $FILE | tee $BUILD_LOG_FILE || exit 1
ID=$(tail -1 build.log | awk '{print $3;}')
