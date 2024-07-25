FROM debian:bullseye

# INSTALL DEPENDENCIES
RUN		apt -y update && \
		apt upgrade -y && \
		apt-get install -y \
			nginx \
            openssl && \
		mkdir -p /etc/nginx/ssl && \
		mkdir -p /var/run/nginx && \
		rm -rf /etc/nginx/sites-available/default

# NGINX CONFIGURATION
COPY	./conf/nginx.conf /etc/nginx/nginx.conf
COPY	./conf/default.conf /etc/nginx/sites-available/default.conf
COPY	./tools/script.sh /tmp/script.sh

RUN		ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/default.conf

EXPOSE	443

# START NGINX
ENTRYPOINT	["sh", "/tmp/script.sh"]