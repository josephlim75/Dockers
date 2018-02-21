FROM golang:alpine as builder
RUN apk add --update git
RUN go get -u -v github.com/shadowsocks/go-shadowsocks2 github.com/xtaci/kcptun/server

FROM chenhw2/alpine:base
MAINTAINER CHENHW2 <https://github.com/chenhw2>

# /usr/bin/{go-ss2, kcp-srv}
COPY --from=builder /go/bin/go-shadowsocks2 /usr/bin/go-ss2
COPY --from=builder /go/bin/server /usr/bin/kcp-srv

ENV SS=ss://AEAD_AES_128_GCM:12345678

ENV KCP=kcp://fast2:aes: \
    KCP_EXTRA_ARGS=''

EXPOSE 8488/tcp 8488/udp 18488/udp

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
