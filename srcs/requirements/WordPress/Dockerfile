FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y \
		wget
RUN wget https://wordpress.org/wordpress-6.6.1.tar.gz -P /var/www
WORKDIR /var/www
RUN tar -xvf wordpress-6.6.1.tar.gz && rm wordpress-6.6.1.tar.gz
RUN chmod -R 755 /var/www/wordpress && \
	chown -R root:root /var/www/wordpress


RUN apt-get update -y && apt-get install -y \
	wget \
	php7.4 \
	php-fpm \
	php-mysql

	
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www/html && \
	mkdir -p /run/php
RUN chown -R www-data:www-data /var/www/html

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/
COPY tools/wp_init.sh .
RUN chmod +x wp_init.sh

# WORKDIR /var/www/html
# EXPOSE 9000

VOLUME [ "/var/www/html" ]
CMD [ "./wp_init.sh" ]