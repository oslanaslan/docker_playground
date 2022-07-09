#!/usr/bin/env bash
ifconfig ens4 up
dhclient
echo 1 > /proc/sys/net/ipv4/conf/all/forwarding
echo 0 > /proc/sys/net/ipv4/conf/all/send_redirects
echo 0 > /proc/sys/net/ipv4/conf/ens3/send_redirects
sleep 25
echo "deb http://download.webmin.com/download/repository sarge contrib" >> /etc/apt/sources.list
wget http://www.webmin.com/jcameron-key.asc
apt-key add jcameron-key.asc
apt-get update
apt-get install -y webmin
