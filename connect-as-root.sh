docker exec -it --user root `docker ps -a | grep "Up "| grep endeca | awk '{print $1}'` /bin/bash
