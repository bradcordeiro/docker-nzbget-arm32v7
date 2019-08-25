FROM arm32v7/alpine:3.10
LABEL build-date="2019-08-25T21:09:27Z"
LABEL name="nzbget-arm32v7"
LABEL description="Nzbget for the arm32v7 architecture"
LABEL url="https://nzbget.net"
LABEL vcs-ref="https://github.com/bradcordeiro/docker-nzbget-arm32v7"

WORKDIR /opt

# Add runtime dependencies
RUN apk add --no-cache openssl

# Fetch and install Nzbget
RUN apk add --no-cache wget && \
    wget https://nzbget.net/download/nzbget-latest-bin-linux.run && \
    chmod +x nzbget-latest-bin-linux.run && \
    ./nzbget-latest-bin-linux.run --arch armhf && \
    rm nzbget-latest-bin-linux.run && \
    apk del wget

# Target Volume for downloaded files
VOLUME /media/Downloads
# Nzbget configuration file
VOLUME /opt/nzbget/nzbget.conf 

EXPOSE 6789

ENTRYPOINT [ "/opt/nzbget/nzbget" ]
CMD ["--server"]
