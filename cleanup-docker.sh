# Remove all stopped containers

echo "cleaning up ..."

# Delete containers

result=`docker ps -a -q -f status=created`
if [[ -n "$result" ]]; then
  docker rm -v $(docker ps -a -q -f status=created)
fi  

result=`docker ps -a -q -f status=exited`
if [[ -n "$result" ]]; then
  docker rm -v $(docker ps -a -q -f status=exited)
fi  

# delete dangling images
result2=`docker images -q -f dangling=true`
if [[ -n "$result2" ]]; then
  docker rmi $(docker images -q -f dangling=true)
fi

# Removes ALL docker containers
# docker rm `docker ps -a -q --no-trunc`

echo "done"
