#!/bin/sh

# soft fail if dir already exists
mkdir -p /etc/reclaim

if [ ! -f /etc/reclaim/api.reclaim.local.der ]
then
    echo "Setting up *.reclaim"

    echo "staring gnunet"
    gnunet-arm -s &> ${HOME}/gnunet.log
    gnunet-identity -C reclaim
    openssl genrsa -des3 -passout pass:xxxx -out server.pass.key 2048
    openssl rsa -passin pass:xxxx -in server.pass.key -out /etc/reclaim/ui.reclaim.local.key
    rm server.pass.key
    openssl req -new -key /etc/reclaim/ui.reclaim.local.key -out server.csr \
        -subj "/C=DE/ST=Bavaria/L=Munich/O=Fraunhofer/OU=SAS/CN=ui.reclaim.local"
    openssl x509 -req -days 3650 -in server.csr -signkey /etc/reclaim/ui.reclaim.local.key -out /etc/reclaim/ui.reclaim.local.crt
    openssl x509 -in /etc/reclaim/ui.reclaim.local.crt -out /etc/reclaim/ui.reclaim.local.der -outform DER
    HEXCERT=`xxd -p /etc/reclaim/ui.reclaim.local.der | tr -d '\n'`
    echo $HEXCERT
    BOXVALUE="6 443 52 3 0 0 $HEXCERT"
    gnunet-namestore -z reclaim -a -n ui -t A -V "$UI_IP" -e 1d -p
    gnunet-namestore -z reclaim -a -n ui -t LEHO -V "ui.reclaim.local" -e 1d -p
    gnunet-namestore -z reclaim -a -n ui -t BOX -V "$BOXVALUE" -e 1d -p


    openssl genrsa -des3 -passout pass:xxxx -out server.pass.key 2048
    openssl rsa -passin pass:xxxx -in server.pass.key -out /etc/reclaim/api.reclaim.local.key
    rm server.pass.key
    openssl req -new -key /etc/reclaim/api.reclaim.local.key -out server.csr \
        -subj "/C=DE/ST=Bavaria/L=Munich/O=Fraunhofer/OU=SAS/CN=api.reclaim.local"
    openssl x509 -req -days 3650 -in server.csr -signkey /etc/reclaim/api.reclaim.local.key -out /etc/reclaim/api.reclaim.local.crt
    openssl x509 -in /etc/reclaim/api.reclaim.local.crt -out /etc/reclaim/api.reclaim.local.der -outform DER
    HEXCERT=`xxd -p /etc/reclaim/api.reclaim.local.der | tr -d '\n'`
    echo $HEXCERT
    BOXVALUE="6 443 52 3 0 0 $HEXCERT"
    gnunet-namestore -z reclaim -a -n api -t A -V "$UI_IP" -e 1d -p
    gnunet-namestore -z reclaim -a -n api -t LEHO -V "api.reclaim.local" -e 1d -p
    gnunet-namestore -z reclaim -a -n api -t BOX -V "$BOXVALUE" -e 1d -p

    gnunet-namestore -z reclaim -a -n demo -t PKEY -V "BTWD21BYAGDH47W0WAM1RF8GZR3YEA9WW6C6XJ51YX3BS944Y9DG" -e never -p

    gnunet-config -s hostlist -o "SERVERS" -V "http://reclaim-identity.io:8080/hostlist http://v10.gnunet.org/hostlist"
    gnunet-config -w
    gnunet-arm -e
fi

echo "staring gnunet"
gnunet-arm -s &> ${HOME}/gnunet.log

gnunet-arm -i rest
gnunet-arm -i reclaim
gnunet-arm -i gns-proxy

gnunet-identity -e reclaim -s gns-proxy

if [ -n "$RECLAIMUI_URL" ]; then
    gnunet-config -s reclaim-rest-plugin -o ADDRESS -V $RECLAIMUI_URL
    gnunet-arm -k rest
    gnunet-arm -i rest
fi

exec gnunet-arm -m
