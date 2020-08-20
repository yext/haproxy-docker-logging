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

You must provide the following arguments to the Makefile:
 * HAPROXY_VERSION: The version number of haproxy to be included in the image
 * IMAGE_VERSION: The version number for the Docker image to be built
 * REGISTRY: The path to the Docker registry to push to
 * NAMESPACE: The namespace of the Docker registry in which `haproxy-docker-logging` will be placed.

In order to generate a Dockerfile for a specific haproxy version, e.g. version 2.2, run:

```
HAPROXY_VERSION=2.2 make generate
```

To build a Docker container image, specify a path to the registry:

```
HAPROXY_VERSION=2.2 IMAGE_VERSION=1.0 REGISTRY=path.to/registry NAMESPACE=somenamespace make generate build
```

To generate a config, build an image, and push it to a registry:

```
HAPROXY_VERSION=2.2 IMAGE_VERSION=1.0 REGISTRY=path.to/registry NAMESPACE=somenamespace make all
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


