#!/bin/sh

mkdir -p $WORDPRESS_PATH
chown -R www-data:www-data $WORDPRESS_PATH

# SSL certificate
openssl req -x509 -nodes -days 365 -newkey rsa:4096 -sha256 \
			-keyout $CERTS_KEY \
			-out $CERTS_CRT \
			-subj "/C=FR/ST=Paris/L=Paris/O=42/OU='${USER}'/CN='${DOMAIN_NAME}'"

# Nginx configuration
sed -i 's|{{DOMAIN_NAME}}|'${DOMAIN_NAME}'|g' /etc/nginx/sites-available/default.conf
sed -i 's|{{CERTS_CRT}}|'${CERTS_CRT}'|g' /etc/nginx/sites-available/default.conf
sed -i 's|{{CERTS_KEY}}|'${CERTS_KEY}'|g' /etc/nginx/sites-available/default.conf
sed -i 's|{{WORDPRESS_PATH}}|'${WORDPRESS_PATH}'|g' /etc/nginx/sites-available/default.conf
sed -i 's|{{WORDPRESS_HOST}}|'${WORDPRESS_HOST}'|g' /etc/nginx/sites-available/default.conf
sed -i 's|{{WORDPRESS_PORT}}|'${WORDPRESS_PORT}'|g' /etc/nginx/sites-available/default.conf

# Start Nginx
nginx -g 'daemon off;'
