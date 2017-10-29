#/bin/bash
/usr/bin/mysqld &
sleep 10s
echo "GRANT ALL ON *.* TO admin@'%' IDENTIFIED BY 'changeme' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql -uroot -p

