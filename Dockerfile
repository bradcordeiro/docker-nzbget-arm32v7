FROM arm32v7/alpine:3.10

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
# Nzbget configuration file, see https://github.com/nzbget/nzbget/blob/develop/nzbget.conf
VOLUME /opt/nzbget/nzbget.conf 

EXPOSE 6789

ENTRYPOINT [ "/opt/nzbget/nzbget" ]
CMD ["--server"]
