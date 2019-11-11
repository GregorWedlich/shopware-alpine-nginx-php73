#!/bin/bash

DOWNLOAD_URL="https://releases.shopware.com/install_5.6.2_6cadc5c14bad4ea8839395461ea42dbc359e9666.zip"

wget -O /var/www/html/shop.zip $DOWNLOAD_URL

cd /var/www/html

unzip -q shop.zip
rm shop.zip