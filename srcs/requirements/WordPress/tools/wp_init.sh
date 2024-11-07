# rm -rf /var/www/html/*

sleep 10

cd /var/www/html
wp core download --allow-root --path=/var/www/html
wp config create --allow-root --path=/var/www/html \
	--dbhost="mariadb" \
	--dbname=$SQL_DATABASE \
	--dbuser=$SQL_USER \
	--dbpass=$SQL_PASSWORD
wp core install --allow-root --path=/var/www/html \
	--url=https://$DOMAIN_NAME \
	--title=$WP_TITLE \
	--admin_user=$WP_ADMIN_USER \
	--admin_password=$WP_ADMIN_PASS \
	--admin_email=$WP_ADMIN_EMAIL \
	--skip-email
echo "Wordpress configured"

echo "Starting fpm"
php-fpm7.4 -F
