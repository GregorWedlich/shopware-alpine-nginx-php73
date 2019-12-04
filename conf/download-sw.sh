#!/bin/bash

DOWNLOAD_URL="https://releases.shopware.com/install_5.6.3_fec7645a72a0393f8a39f48ddd6c27e138f44513.zip"

wget -O /home/shopware_files/download/shop.zip $DOWNLOAD_URL

cd /home/shopware_files/download

unzip -q shop.zip

cp -R /home/shopware_files/download/* /var/www/html/

rm shop.zip
