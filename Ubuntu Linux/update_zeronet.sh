#!/bin/bash

echo \
"
Zeronet updater for Ubuntu Linux.
"

if [ "$EUID" -ne 0 ]
  then echo "Please run as root."
  exit
fi

if [ ! -d /opt/zeronet ]; then
    echo 'Directory /opt/zeronet does not exist!'
    exit
fi

. /etc/lsb-release

if [ "$DISTRIB_RELEASE" = "15.04" ]; then
    systemctl stop zeronet.service
else
    zeronet stop
fi

pushd /opt/zeronet
sudo -u zeronet git pull
popd


if [ "$DISTRIB_RELEASE" = "15.04" ]; then
    systemctl start zeronet.service
else
    zeronet start
fi
