FROM alpine:3.13.4
MAINTAINER Wan Yi <root@wanyi.dev>

RUN apk add --no-cache mysql-client bash gzip
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
