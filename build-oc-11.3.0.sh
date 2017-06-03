#!/bin/sh

set -o pipefail

# Build log file
BUILD_LOG_FILE=/tmp/build.log

if [ -e $BUILD_LOG_FILE ]
then
  mv $BUILD_LOG_FILE $BUILD_LOG_FILE.`date +%s`
fi


# MDEX Docker Build
DOCKERFILE_LOC=oc-11.3.0/mdex
IMAGE=ramnishkalsi/oc-mdex
VERSION=0.1

docker build -t ${IMAGE}:${VERSION} $DOCKERFILE_LOC | tee $BUILD_LOG_FILE || exit 1
ID=$(tail -1 build.log | awk '{print $3;}')
