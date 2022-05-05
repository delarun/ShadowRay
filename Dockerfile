FROM ubuntu

ARG V2RAY_VERSION=v1.3.1
COPY ./data /data
RUN chmod +x /data/conf/set_nginx.sh
RUN chmod +x /data/conf/set_shadow.sh
RUN chmod +x /data/entrypoint.sh

ARG DEBIAN_FRONTEND=noninteractive
RUN apt update -y
RUN apt install -y wget qrencode shadowsocks-libev nginx-light curl
RUN mkdir -p /etc/shadowsocks-libev
RUN curl -L "https://github.com/shadowsocks/v2ray-plugin/releases/download/${V2RAY_VERSION}/v2ray-plugin-linux-amd64-${V2RAY_VERSION}.tar.gz" -o /tmp/v2ray-plugin.tar.gz
RUN cd /tmp && tar -xvf /tmp/v2ray-plugin.tar.gz
RUN mv /tmp/v2ray-plugin_linux_amd64 /usr/local/bin/v2ray-plugin

CMD /data/entrypoint.sh