#!/bin/bash

export DOMAIN="$AppName.herokuapp.com"

/data/conf/set_shadow.sh >> /etc/shadowsocks-libev/config.json

/data/conf/set_nginx.sh >> /etc/nginx/conf.d/ss.conf


plugin=$(echo -n "v2ray;path=/shadow;host=${AppName}.herokuapp.com;tls" | sed -e 's/\//%2F/g' -e 's/=/%3D/g' -e 's/;/%3B/g')
ss="ss://$(echo -n ${ENCRYPT}:${PASSWORD} | base64 -w 0)@${AppName}.herokuapp.com:443?plugin=${plugin}" 
echo -n "${ss}" | qrencode -s 6 -o /data/web/qr.png

ss-server -c /etc/shadowsocks-libev/config.json &
rm -rf /etc/nginx/sites-enabled/default
nginx -g 'daemon off;'