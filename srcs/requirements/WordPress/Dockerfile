FROM debian:bullseye

RUN apt-get update -y && apt-get install -y \
	php \
	php-fpm \
	php-mysqli \
	php-gd \
	php-curl \
	curl \
	unzip \
	mariadb-client
	& apt-get clean

WORKDIR /var/www/html

RUN curl -o wordpress.tar.gz https://wordpress.org/latest.tar.gz && \
	tar -xzf wordpress.tar.gz --strip-components=1 & \
	rm wordpress.tar.gz

RUN chown -R www-data:www-data /var/www/html

EXPOSE 9000

CMD ["php-fpm", "--nodaemonize"]