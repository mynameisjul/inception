FROM debian:bullseye

# Installation of MariaDB
RUN apt update && apt upgrade -y && \
	apt install -y mariadb-server && \
	rm -rf /var/lib/apt/lists/*

# Exposing default port
EXPOSE 3306

COPY conf/50-server.conf /etc/mysql/mariadb.conf.d/
COPY tools/mysql_init.sh /usr/local/bin/mysql_init.sh

RUN chmod +x /usr/local/bin/mysql_init.sh

ENTRYPOINT [ "mysql_init.sh" ]
# Setting default start command
CMD ["mariadb"]