#!/bin/sh
# Render supplies $PORT (default 10000). UUID and WS_PATH are Render env vars
# set in the dashboard — they are NOT baked into the repo.
set -e
PORT="${PORT:-10000}"
: "${UUID:?UUID env var is required}"
: "${WS_PATH:?WS_PATH env var is required}"
sed -e "s/__PORT__/$PORT/" -e "s/__UUID__/$UUID/" -e "s#__WS_PATH__#$WS_PATH#" \
  /config.template.json > /usr/local/etc/xray/config.json
exec /usr/local/bin/xray run -config /usr/local/etc/xray/config.json
