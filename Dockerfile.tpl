FROM haproxy:HAPROXY_VERSION-alpine

RUN set -exo pipefail \
    && apk update \
    && apk add --no-cache \
        rsyslog ca-certificates wget \
    && update-ca-certificates \
    && mkdir -p /etc/rsyslog.d \
    && touch /var/log/haproxy.log \
    && ln -sf /dev/stdout /var/log/haproxy.log

RUN wget -O /usr/local/bin/dumb-init \
        https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64 \
    && chmod +x /usr/local/bin/dumb-init

COPY docker-entrypoint.sh /
COPY rsyslog.conf /etc/rsyslog.d/

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]

CMD ["/docker-entrypoint.sh", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]
