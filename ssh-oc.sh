# this will find the running endeca 11.3.0 instance & ssh into it.

docker exec -it `docker ps -a | grep "Up "| grep endeca | awk '{print $1}'` /bin/bash

# service init-endeca-tools start 
# service init-endeca-ps start 
# service init-endeca-cas start 
