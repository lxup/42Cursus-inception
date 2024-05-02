FROM debian:buster

# INSTALL DEPENDENCIES
RUN		apt -y update
RUN		apt install -y \
			mariadb-server

COPY	./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# LAUNCH SCRIPT
COPY	./tools/script.sh /script.sh
RUN		chmod 755 /script.sh

CMD		["/script.sh"]