FROM debian:bullseye

# INSTALL DEPENDENCIES
RUN		apt -y update && \
		apt install -y php && \
		PHP_VERSION=$(php -v | head -n 1 | cut -d " " -f 2 | cut -d "." -f 1,2) && \
		apt install -y \
			php-fpm \
			php-mysql \
			php-cli \
			php-mbstring \
			mariadb-client \
			curl && \
		rm -rf /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf && \
		mkdir -p /run/php

# LAUNCH SCRIPT
COPY	./tools/script.sh /tmp/script.sh
COPY	./conf/www.conf /tmp/www.conf
# COPY	./conf/www.conf /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf

RUN		chmod 755 /tmp/script.sh

# Not supposed to be exposed to the host machine
# EXPOSE	9000

ENTRYPOINT	["sh", "/tmp/script.sh"]
