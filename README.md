### Source
- https://github.com/chenhw2/Dockers/tree/SS-KCP-SERVER
  
### Thanks
- https://github.com/shadowsocks/go-shadowsocks2
- https://github.com/xtaci/kcptun
  
### Usage
```
$ docker pull chenhw2/ss-kcp-server

$ docker run -d \
    -e "SS=[ss://cipher:pass]" \
    -e "KCP=[kcp://mode:crypt:key]" \
    -p 8488:8488/tcp -p 8488:8488/udp -p 18488:18488/udp \
    chenhw2/ss-kcp-server
```

### ENV
```
# ss://cipher:pass
ENV SS=ss://AEAD_AES_128_GCM:12345678

# kcp://mode:crypt:key
ENV KCP=cp://fast2:aes:
ENV KCP_EXTRA_ARGS=''

```
