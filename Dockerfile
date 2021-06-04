FROM alpine:latest
RUN apk add --no-cache python3
RUN apk add --no-cache py3-pip
ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh
CMD /entrypoint.sh
