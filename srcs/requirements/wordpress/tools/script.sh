#!/bin/bash

PHP_VERSION=$(php -v | head -n 1 | cut -d " " -f 2 | cut -d "." -f 1,2)
# echo "PHP_VERSION: ${PHP_VERSION}"

# Move the configuration file to the correct location
mv /tmp/www.conf /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf

sed -i 's|{{WORDPRESS_PORT}}|'${WORDPRESS_PORT}'|g' /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf

if [ -f "$WORDPRESS_PATH/wp-config.php" ]; then
	echo "WordPress already installed"
else
	# Install WordPress
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp

	wp core download --path=$WORDPRESS_PATH --allow-root
	cd $WORDPRESS_PATH
	wp config create --dbname=$WORDPRESS_DB_NAME --dbuser=$WORDPRESS_DB_USER --dbpass=$WORDPRESS_DB_PASSWORD --dbhost=mariadb --dbprefix=$WORDPRESS_DB_PREFIX --skip-check --allow-root
	wp core install --url=$DOMAIN_NAME --title=$WORDPRESS_TITLE --admin_user=$WORDPRESS_ADMIN_USER --admin_password=$WORDPRESS_ADMIN_PASSWORD --admin_email=$WORDPRESS_ADMIN_EMAIL --skip-email --allow-root
	wp user create $WORDPRESS_USER1_USER $WORDPRESS_USER1_EMAIL --role=editor --user_pass=$WORDPRESS_USER1_PASSWORD --allow-root

	# Redis
	wp config set WP_CACHE_KEY_SALT "$DOMAIN_NAME" --allow-root
	wp config set WP_CACHE true --raw --allow-root
	wp config set WP_REDIS_HOST redis --allow-root
	wp plugin install redis-cache --activate --allow-root
	wp redis enable --allow-root
fi

/usr/sbin/php-fpm${PHP_VERSION} -F