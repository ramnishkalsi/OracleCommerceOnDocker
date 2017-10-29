FROM mysql/mysql-server:5.7
MAINTAINER Ramnish Kalsi <ramnish.kalsi@gmail.com>

RUN yum install -y procps && \
    yum install -y vi

# RUN ln -s /bin/true /sbin/initctl
# RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

ADD startup.sh /opt/startup.sh

RUN chmod 755 /opt/startup.sh

EXPOSE 3306

CMD ["/bin/bash", "/opt/startup.sh"]
