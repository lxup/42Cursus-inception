FROM debian:bullseye

# INSTALL DEPENDENCIES
RUN		apt -y update && \
		apt install -y \
			php \
			php-fpm \
			php-mysql \
			php-cli \
			php-mbstring \
			php-gettext \
			mariadb-client \
			curl && \
		rm -rf /etc/php/7.3/fpm/pool.d/www.conf && \
		mkdir -p /run/php

# LAUNCH SCRIPT
COPY	./tools/script.sh /tmp/script.sh
COPY	./conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

RUN		chmod 755 /tmp/script.sh

# Not supposed to be exposed to the host machine
# EXPOSE	9000

ENTRYPOINT	["sh", "/tmp/script.sh"]
