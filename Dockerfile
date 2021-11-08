FROM alpine
RUN apk update && apk add git openssh rsync
COPY . /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
