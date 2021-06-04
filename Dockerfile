FROM teddysun/xray
RUN apk add --no-cache alpine-conf
ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh
CMD /entrypoint.sh
