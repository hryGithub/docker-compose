#!/bin/bash


#start openvpn

#genconfig
if [ ! -f '/etc/openvpn/server.conf' ];then
    genconfig()
fi
#init-pki
if [ ! -f '/etc/openvpn/ca.crt'];then
    init_pki()
fi

genconfig(){
    echo 1
}

init-pki(){
    cd $OPENVPN 
    easyrsa init-pki
    easyrsa build-ca nopass
    easyrsa gen-dh
    easyrsa build-server-full server nopass
    openvpn --genkey --secret $EASYRSA_PKI/ta.key
    cp $EASYRSA/pki/{ca.crt,ta.key,issued/server.crt,private/server.key,dh.pem} "/etc/openvpn/"
}

httpd -DFOREGROUND
#/usr/sbin/openvpn --config /etc/openvpn/server.conf