FROM debian:bullseye

# Installation of MariaDB
RUN apt update && apt upgrade -y && \
	apt install -y mariadb-server

COPY ./conf/50-server.conf /etc/mysql/mariadb.conf.d/
COPY ./tools/mysql_init.sh .

RUN chmod +x mysql_init.sh

# Exposing default port
EXPOSE 3306
VOLUME [ "/var/lib/mysql" ]

# Setting default start command
CMD ["./mysql_init.sh"]