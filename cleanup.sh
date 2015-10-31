docker rm `docker ps -a -q --no-trunc`
docker rmi -f $(docker images -q -f "dangling=true")

