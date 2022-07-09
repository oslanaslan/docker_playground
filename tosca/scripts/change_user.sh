#!/usr/bin/env bash
# $1 - username
# $2 - password
cat '/etc/webmin/miniserv.users' | sed "s/root/$1/" >> /etc/webmin/miniserv.users
cat '/etc/webmin/webmin.acl' | sed "s/root/$1/" >> /etc/webmin/webmin.acl
/usr/share/webmin/changepass.pl /etc/webmin $1 $2
sed -i "s/\(ssl *= *\).*/\10/" /etc/webmin/miniserv.conf
/etc/init.d/webmin restart