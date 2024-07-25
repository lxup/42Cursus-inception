FROM debian:bullseye

# INSTALL DEPENDENCIES
RUN		apt update -y && \
		apt upgrade -y && \
		apt-get install -y \
			mariadb-server \
			mariadb-client && \
		mkdir -p /var/run/mysqld && \
		chown -R mysql:mysql /var/run/mysqld && \
		chown -R mysql:mysql /etc/mysql

COPY	./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY	./conf/init.sql /tmp/init.sql
COPY	./tools/script.sh /tmp/script.sh

RUN		chown -R mysql:mysql /etc/mysql && \
		chown -R mysql:mysql /tmp/

# Not supposed to be exposed to the host machine
# EXPOSE	3306

USER	mysql

ENTRYPOINT	["sh", "/tmp/script.sh"]