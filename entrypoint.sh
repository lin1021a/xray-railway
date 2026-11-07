#!/bin/sh
set -e
# Railway 注入 PORT；TLS 由 Railway 边缘终结，xray 内部只跑 WS 明文
PORT="${PORT:-8080}"
UUID="${XRAY_UUID:?need XRAY_UUID}"
WS_PATH="${XRAY_WS_PATH:-ray}"
mkdir -p /usr/local/etc/xray
sed -e "s/__PORT__/${PORT}/g" \
    -e "s/__UUID__/${UUID}/g" \
    -e "s/__WS_PATH__/${WS_PATH}/g" \
    /app/config.template.json > /usr/local/etc/xray/config.json
exec xray run -config /usr/local/etc/xray/config.json
