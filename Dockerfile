ARG CADDY_VERSION=2

FROM caddy:${CADDY_VERSION}-builder-alpine AS caddy_builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare

FROM caddy:${CADDY_VERSION} AS caddy

WORKDIR /srv/api

COPY --from=caddy_builder /usr/bin/caddy /usr/bin/caddy
COPY ./Caddyfile /etc/caddy/Caddyfile