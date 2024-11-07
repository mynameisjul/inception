FROM debian:bullseye

RUN apt-get update -y && apt-get install -y \
	php \
	php-fpm \
	php-mysql \
	php-gd \
	php-curl \
	curl \
	unzip \
	mariadb-client \
	&& apt-get clean

WORKDIR /var/www/html

RUN curl -o wordpress.tar.gz https://wordpress.org/latest.tar.gz && \
	tar -xzf wordpress.tar.gz --strip-components=1 && \
	rm wordpress.tar.gz

RUN chown -R www-data:www-data /var/www/html

COPY tools/wp_init.sh .
RUN chmod +x wp_init.sh

# EXPOSE 9000

VOLUME [ "/var/www/html" ]
CMD [ "sh", "./wp_init.sh" ]