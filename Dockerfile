FROM alpine:latest
WORKDIR /root
COPY xray.sh /root/xray.sh
COPY config.json /etc/xray/config.json
RUN set -ex \
	&& apk add --no-cache tzdata ca-certificates \
	&& apk add --no-cache openssl \
	&& mkdir -p /var/log/xray /usr/local/share/xray \
	&& chmod +x /root/xray.sh \
	&& /root/xray.sh \
	&& rm -fv /root/xray.sh \
	&& wget -O /usr/local/share/xray/geosite.dat https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.dat \
	&& wget -O /usr/local/share/xray/geoip.dat https://github.com/v2fly/geoip/releases/latest/download/geoip.dat

VOLUME /etc/xray
ENV TZ=Asia/Colombo
ADD runxray.sh /runxray.sh
RUN chmod +x /runxray.sh
RUN openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 \
    	-subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com" \
    	-keyout /etc/xray/xray.key  -out /etc/xray/xray.crt
RUN chmod 777 /etc/xray/xray.key
CMD /runxray.sh
