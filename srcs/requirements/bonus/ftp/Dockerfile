FROM debian:buster

# INSTALL DEPENDENCIES
RUN apt update -y && \
	apt install -y \
		vsftpd

COPY ./tools/script.sh /tmp/script.sh

ENTRYPOINT ["sh", "/tmp/script.sh"]
