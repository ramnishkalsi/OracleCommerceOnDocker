#!/bin/sh

start=`date +%s`

BUILD_HOME=/Users/ramnishkalsi/docker-builds/OracleCommerceOnDocker

set -o pipefail

# Build log file
BUILD_LOG_FILE=$BUILD_HOME/tmp/build-endeca.log

if [ -e $BUILD_LOG_FILE ]
then
  mv $BUILD_LOG_FILE $BUILD_LOG_FILE.`date +%s`
fi

# Endeca build
DOCKERFILE_LOC=.
IMAGE=ramnishkalsi/endeca
VERSION=0.5

docker build -t ${IMAGE}:${VERSION} $DOCKERFILE_LOC | tee $BUILD_LOG_FILE || exit 1

end=`date +%s`
runtime=$((end-start))

echo "Time taken: $runtime seconds"