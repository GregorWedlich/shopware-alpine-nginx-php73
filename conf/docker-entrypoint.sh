#!/bin/bash

set -e

cd /home/shopware_files/download

if [ -z "$(ls -A /var/www/html/themes)" ]; then
    echo "Move themes folder from shopware clean download"
    cp -R /home/shopware_files/download/themes/* /var/www/html/themes/
    
    echo "Set permissions"
    chown -R nobody.nobody /var/www/html/themes/
fi

exec "$@";
