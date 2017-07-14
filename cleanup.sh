#!/bin/sh

echo "cleaning up ..."

echo "deleting stopped containers"
result=`docker ps -a -q -f status=exited`
if [[ -n "$result" ]]; then
  docker rm -v $(docker ps -a -q -f status=exited)
else
  echo "no stopped containers"
fi  

# delete dangling images
echo "deleting dangling images"
result2=`docker images -q -f dangling=true`
if [[ -n "$result2" ]]; then
  docker rmi $(docker images -q -f dangling=true)
else
  echo "no dangling images"
fi

echo "done"