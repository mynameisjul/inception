cd /var/www/html

if [ -f ./wp-config.php ]
then
    echo "Worpress already configured"
else
    wp core download --allow-root
    wp config create --allow-root \
                    --dbhost=$SQL_HOSTNAME \
                    --dbname=$SQL_DATABASE \
                    --dbuser=$SQL_USER \
                    --dbpass=$SQL_PASSWORD
    wp core install --allow-root \
                    --url=https://$DOMAIN_NAME \
                    --title=$WP_TITLE \
                    --admin_user=$WP_ADMIN_USER \
                    --admin_password=$WP_ADMIN_PASSWORD \
                    --admin_email=$WP_ADMIN_EMAIL \
                    --skip-email
    echo "Wordpress configured"
fi

echo "Starting fpm"
php-fpm7.4 -F
