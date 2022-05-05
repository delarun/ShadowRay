#!/bin/bash
cat <<EOF
server {
    listen       ${PORT};
    listen       [::]:${PORT};
    root /data/web;
    index index.html;
    location = /shadow {
        if (\$http_upgrade != "websocket") { # WebSocket return this when negotiation fails 404
            return 404;
        }
        proxy_redirect off;
        proxy_pass http://127.0.0.1:8008;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host \$http_host;
    }
}
EOF