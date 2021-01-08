FROM alpine:latest

LABEL \
  maintainer="luoqiz <luoqiangzheng@gmail.com>" \
  org.opencontainers.image.title="docker-images-latest-version" \
  org.opencontainers.image.description="An alpine based Docker image with curl and jq" \
  org.opencontainers.image.authors="luoqiz <luoqiangzheng@gmail.com>" \
  org.opencontainers.image.url="https://github.com/luoqiz/docker-images-latest-version" \
  org.opencontainers.image.vendor="https://luoqiz.top" \
  org.opencontainers.image.licenses="MIT"

RUN apk --no-cache add curl jq

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]