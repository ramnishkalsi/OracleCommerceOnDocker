docker run -it -p 3306:3306 -h localhost -v /usr/local/mysql-docker:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d ramnishkalsi/mysql:0.1 /bin/bash
