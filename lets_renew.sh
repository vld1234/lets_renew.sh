#!/bin/bash
cp -a /opt/site/bwdata/letsencrypt/archive/siet.io "site_ssl_backup/site.io-$(date +"%Y%m%d-%H%M")"
date=$(date +"%d")
if (( "$date" <= 30 ));
        then
        certbot certonly --dns-dnsmadeeasy --dns-dnsmadeeasy-credentials /root/secrets/certbot/dnsmadeeasy.ini -d site.io >> "/var/log/let
sencrypt/letsencrypt-renew.log"
        echo "Certs updated" >> /var/log/letsencrypt/letsencrypt-renew.log
else
        echo "Certs NOT updated" >> /var/log/letsencypt/letsencrypt-renew.log
exit
fi
cp -a /etc/letsencrypt/live/site.io/* /opt/site/bwdata/letsencrypt/live/site.io/
chown nobody:nogroup /opt/site/bwdata/letsencrypt/live/site.io/
cp -a /etc/letsencrypt/archive/site.io/* /opt/site/bwdata/letsencrypt/archive/site.io/
chown nobody:nogroup /opt/site/bwdata/letsencrypt/archive/site.io/
/usr/bin/docker restart site-nginx
