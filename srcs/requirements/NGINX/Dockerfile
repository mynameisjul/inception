FROM debian:bullseye

RUN apt-get update && apt-get install -y \
	openssl \
	nginx \
	&& apt-get clean

RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/ssl/jblaye.42.fr.key \
	-out /etc/nginx/ssl/jblaye.42.fr.crt \
	-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=jblaye.42.fr/UID=jblaye"
RUN chmod 600 /etc/nginx/ssl/jblaye.42.fr.crt && \
	chmod 600 /etc/nginx/ssl/jblaye.42.fr.key

RUN mkdir -p /var/run/nginx
COPY conf/nginx.conf /etc/nginx/
RUN chmod -R 755 /var/www/html && chown -R www-data:www-data /var/www/html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]