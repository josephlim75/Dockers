#!/bin/sh

# ss://cipher:pass
# SS=${SS:-ss://AEAD_AES_128_GCM:12345678}

# kcp://mode:crypt:key
# KCP=${KCP:-kcp://fast2:aes:}
# KCP_EXTRA_ARGS=${KCP_EXTRA_ARGS:-''}

echo "#CONFIG: ${SS}@:8488"
echo "#CONFIG: ${KCP} ${KCP_EXTRA_ARGS}"
echo '=================================================='
echo

# Path Init
ss2_cli="/usr/bin/go-ss2"
kcp_cli="/usr/bin/kcp-srv"
ss2_port=8488

# Gen kcp_conf
kcp2cmd(){
  kcp=$1
  kcp_extra_agrs=$2
  if [ "Z${kcp_extra_agrs}" == "Z" ]; then
    echo "${kcp_extra_agrs}"
  else
    cmd='--mode \1 --crypt \2'
    cli=$(echo ${kcp} | sed "s#kcp://\([^:]*\):\([^:]*\):\([^:]*\).*#${cmd}#g")
    key=$(echo ${kcp} | sed "s#kcp://\([^:]*\):\([^:]*\):\([^:]*\).*#\3#g")
    [ "Z${key}" = 'Z' ] || cli=$(echo "${cli} --key ${key}")
    echo "${cli} ${kcp_extra_agrs}"
  fi
}

kcp_cmd=$(kcp2cmd ${KCP} ${KCP_EXTRA_ARGS})

( ${ss2_cli} -s ${SS}@:${ss2_port} -verbose ) &

${kcp_cli} -t 127.0.0.1:${ss2_port} -l :1${ss2_port} ${kcp_cmd}
