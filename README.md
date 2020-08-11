HAProxy with logging to STDOUT
=====

### About this image

This image uses latest Alpine-based HAProxy image, starts rsyslog and provides STDOUT logging. Access HAProxy logs through `docker logs -f <id or name of your container>`.

### Configuration

To use STDOUT logging with your Docker container, please use this snippet in your HAProxy config:

```
global
    log 127.0.0.1 local0 debug

defaults
    log global
```

### Usage

Please visit [official HAProxy repository](https://hub.docker.com/_/haproxy/) for information on how to use this image. It is pretty the same.

### Deployment

In order to generate a Dockerfile for a specific haproxy version, e.g. version 2.2, run:

```
VERSION=2.2 make generate
```

To build a Docker container image, specify a path to the registry:

```
VERSION=2.2 REGISTRY_PATH=foo/bar make generate build
```

To generate a config, build an image, and push it to a registry:

```
VERSION=2.2 REGISTRY_PATH=foo/bar make all
```

### Example

Mounting a HAProxy configuration file is mandatory. This image doesn't include any configuration itself. See the `-v` section below.

```
docker run -d \
           -p 8080:9000 \
           -v $(pwd)/haproxy.cfg.EXAMPLE:/usr/local/etc/haproxy/haproxy.cfg:ro \
           --name haproxy \
           mminks/haproxy-docker-logging
```

#### Reload HAProxy

Reload your HAProxy in case of config changes without restarting the complete container. Send a SIGHUP signal to the container an the HAProxy process will reload gracefully.

```
docker kill -s SIGHUP haproxy
```

### Contribution

This repository is a fork of [mminks/haproxy-docker-logging](https://github.com/mminks/haproxy-docker-logging).


