FROM debian:buster

RUN apt-get update -y && apt-get install telnet mariadb-server vim -y

COPY mariaScript/script.sh /script.sh
RUN chmod +x /script.sh
CMD ["/script.sh"]