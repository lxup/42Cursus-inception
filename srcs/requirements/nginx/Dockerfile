FROM debian:buster

# INSTALL DEPENDENCIES
RUN		apt -y update
RUN		apt install -y \
			nginx \
            openssl

# SSL CERTIFICATE
RUN		mkdir -p /etc/nginx/ssl
RUN		openssl req -x509 -nodes -days 365 -newkey rsa:4096 -sha256 \
			-keyout /etc/nginx/ssl/ssl.key \
			-out /etc/nginx/ssl/ssl.crt \
			-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=lquehec.42.fr/UID=lquehec"

# NGINX CONFIGURATION
RUN		mkdir -p /var/run/nginx
COPY	./conf/nginx.conf /etc/nginx/nginx.conf

RUN		chmod 755 /var/www/html
RUN		chown -R www-data:www-data /var/www/html

# START NGINX
CMD		["nginx", "-g", "daemon off;"]