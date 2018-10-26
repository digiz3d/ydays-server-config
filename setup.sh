#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi


apt update
apt upgrade -y
apt install -y git build-essential libpcre3-dev libssl-dev zlib1g-dev

cd

git clone https://github.com/arut/nginx-rtmp-module.git

wget https://nginx.org/download/nginx-1.15.5.tar.gz
tar -xvzf nginx-1.15.5.tar.gz

cd ~/nginx-1.15.5
./configure --add-module=/root/nginx-rtmp-module
make
make install

yes | cp ~/ydays-server-config/nginx.conf /usr/local/nginx/conf/nginx.conf
yes | cp ~/ydays-server-config/nginx.service /lib/systemd/system/nginx.service
systemctl enable nginx
