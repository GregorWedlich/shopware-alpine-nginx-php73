#!/bin/bash

DOWNLOAD_URL="https://releases.shopware.com/install_5.6.2_6cadc5c14bad4ea8839395461ea42dbc359e9666.zip"

wget -O /home/shopware_files/download/shop.zip $DOWNLOAD_URL

cd /home/shopware_files/download

unzip -q shop.zip

cp -R /home/shopware_files/download/* /var/www/html/

rm shop.zip
