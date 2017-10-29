#!/bin/sh

start=`date +%s`

BUILD_HOME=/Users/ramnishkalsi/docker-builds/OracleCommerceOnDocker

set -o pipefail

# Build log file
BUILD_LOG_FILE=$BUILD_HOME/tmp/build-mysql.log

if [ -e $BUILD_LOG_FILE ]
then
  mv $BUILD_LOG_FILE $BUILD_LOG_FILE.`date +%s`
fi

# Endeca build
DOCKERFILE_LOC=mysql
IMAGE=ramnishkalsi/mysql
VERSION=0.1

docker build -t ${IMAGE}:${VERSION} $DOCKERFILE_LOC | tee $BUILD_LOG_FILE || exit 1

end=`date +%s`
runtime=$((end-start))

echo "Time taken: $runtime seconds"