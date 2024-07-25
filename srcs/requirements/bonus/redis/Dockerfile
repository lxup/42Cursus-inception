FROM debian:bullseye

# INSTALL DEPENDENCIES
RUN	apt-get -y update && \
	apt install redis-server -y

# Not supposed to be exposed to the host machine
# EXPOSE	6379

CMD	["redis-server", "--protected-mode no"]