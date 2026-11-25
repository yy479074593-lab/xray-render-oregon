# Xray VLESS+WS on Render Free (Oregon) — same recipe as the Cloady node.
# TLS is terminated by Render's edge (443 -> $PORT, plain HTTP/WS inside).
# Render's default health check is a TCP probe, so do NOT set healthCheckPath
# in render.yaml: Xray listening on $PORT passes it, even though GET / is 404.
FROM ghcr.io/xtls/xray-core:latest AS xray
FROM alpine:3.22
RUN apk add --no-cache ca-certificates
COPY --from=xray /usr/local/bin/xray /usr/local/bin/xray
COPY --from=xray /usr/local/share/xray/ /usr/local/share/xray/
COPY entrypoint.sh /entrypoint.sh
COPY config.template.json /config.template.json
RUN chmod +x /entrypoint.sh
CMD ["/entrypoint.sh"]
