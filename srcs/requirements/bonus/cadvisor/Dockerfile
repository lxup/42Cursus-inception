FROM debian:buster

# INSTALL DEPENDENCIES
RUN apt update -y && \
	apt install -y \
		wget

# DOWNLOAD AND INSTALL CADVISOR
ARG TARGETARCH
RUN case $TARGETARCH in \
        arm) \
            wget https://github.com/google/cadvisor/releases/download/v0.49.1/cadvisor-v0.49.1-linux-arm -O cadvisor; \
            chmod +x cadvisor; \
			;; \
        arm64) \
            wget https://github.com/google/cadvisor/releases/download/v0.49.1/cadvisor-v0.49.1-linux-arm64 -O cadvisor; \
			chmod +x cadvisor; \
            ;; \
        amd64) \
            wget https://github.com/google/cadvisor/releases/download/v0.49.1/cadvisor-v0.49.1-linux-amd64 -O cadvisor; \
            chmod +x cadvisor; \
            ;; \
        *) \
            echo "Unsupported architecture: $TARGETARCH"; \
            exit 1; \
            ;; \
    esac

# EXPOSE PORT
EXPOSE 8080

CMD ["./cadvisor"]
