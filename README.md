# docker-nzbget-arm32v7

Dockerfile to build [Nzbget](https://nzbget.net) for the ARM architecture. Based on Alpine Linux for small image size.

## Boards Tested
* Raspberry Pi 3
* Asus Tinkerboard

## Usage
You can pull the built image with

```bash
docker pull bradcordeiro/nzbget-arm32v7
```

The image uses at least two volume mounts, one to an `nzbget.conf` file to persist/tweak Nzbget configuration between deployments, and one to a folder for downloaded files. For an example `nzbget.conf`, see [https://github.com/nzbget/nzbget/blob/develop/nzbget.conf]

### Run Script Example

```bash
docker run -dit \
  -v /path/to/nzbget.conf:/opt/nzbget/nzbget.conf \
  -v /path/to/downloads:/media/Downloads \
  -p 6789:6789
  nzbget-image-name
```

### Docker-compose example

```yml
version: '3'
services:
  nzbget:
    build: .
    restart: unless-stopped
    command: ["--server", "--option", "OutputMode=loggable"]
    ports:
      - "6789:6789"
    volumes:
      - /path/to/nzbget.conf:/opt/nzbget/nzbget.conf
      - /path/to/downloads:/media/Downloads
```