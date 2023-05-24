#!/bin/sh
mkdir -p /var/www/html
cd /var/www/html

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar

mv wp-cli.phar /usr/local/bin/wp

wp core download --allow-root
chown www-data:www-data * */*

mv ./wp-config-sample.php ./wp-config.php
sed -i -r "s/'database_name_here'/'$WP_DBNAME'/1" wp-config.php
sed -i -r "s/'username_here'/'$WP_DBUSR'/1" wp-config.php
sed -i -r "s/'password_here'/'$WP_DBPWD'/1" wp-config.php
sed -i -r "s/localhost/maria-db/1"    wp-config.php

wp core install --url=$WP_URL --title=$WP_TITLE --admin_user=$WP_ADMINUSER --admin_password=$WP_ADMINPWD --admin_email=$WP_ADMINEMAIL --allow-root
wp user create $WP_NEWUSR $WP_NEWEMAIL --role=author --user_pass=$WP_NEWUSRPWD --allow-root

sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf
mkdir /run/php
/usr/sbin/php-fpm7.3 -F
