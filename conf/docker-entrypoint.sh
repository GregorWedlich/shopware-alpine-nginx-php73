#!/bin/bash

set -e

cd /home/shopware_files/download

if [ -z "$(ls -A /var/www/html/themes)" ]; then
    echo "Move themes folder from shopware clean download"
    cp -R /home/shopware_files/download/themes/* /var/www/html/themes/
    
    echo "Set permissions"
    chown -R nobody.nobody /var/www/html/themes/
fi

if [ -z "$(ls -A /var/www/html/engine/Shopware/Plugins)" ]; then
    echo "Move plugin folder from shopware clean download"
    cp -R /home/shopware_files/download/engine/Shopware/Plugins/* /var/www/html/engine/Shopware/Plugins/
    
    echo "Set permissions"
    chown -R nobody.nobody /var/www/html/engine/Shopware/Plugins/
fi

if [ -z "$(ls -A /var/www/html/custom)" ]; then
    echo "Move plugins folder SW >= 5.2 from shopware clean download"
    cp -R /home/shopware_files/download/custom/* /var/www/html/custom/
    
    echo "Set permissions"
    chown -R nobody.nobody /var/www/html/custom/
fi

exec "$@";
