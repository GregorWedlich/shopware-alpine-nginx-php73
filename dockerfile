FROM alpine:3.10
LABEL Maintainer="Gregor Wedlich <gregor.wedlich@gmail.com>" \
    Description="Alpine Linux Lightweight container with NGINX 1.16, PHP-FPM7.3 and Shopware5.6.2"

# Install packages
RUN apk update && \
    apk --no-cache add php7 php7-cli php7-fpm php7-common php7-mysqli php7-curl \
    php7-json php7-zip php7-gd php7-xml php7-mbstring php7-opcache php7-session \
    php7-simplexml php7-pdo php7-pdo_mysql nginx php7-iconv php7-fileinfo php7-ftp \
    php7-opcache php7-pecl-apcu php7-dom php7-tokenizer supervisor curl nano unzip bash

# Configure nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Remove default server definition
RUN rm /etc/nginx/conf.d/default.conf

# Configure PHP-FPM
COPY conf/fpm-pool.conf /etc/php7/php-fpm.d/www.conf
COPY conf/php.ini /etc/php7/conf.d/custom.ini

# Important PHP Settings - SW standard values
ENV PHP.max_execution_time=30 \
    PHP.memory_limit=256M \
    PHP.upload_max_filesize=6M \
    PHP.post_max_size=8M

# PHP limits
# RUN sed -i -e 's/upload_max_filesize.*/upload_max_filesize = 256M/g' /etc/php7/php.ini && \
#     sed -i -e 's/post_max_size.*/post_max_size = 128M/g' /etc/php7/php.ini && \
#     sed -i -e 's/memory_limit.*/memory_limit = 512M/g' /etc/php7/php.ini

# Add Shopware Settings
RUN mkdir -p /etc/nginx/global/
COPY conf/shopware.conf /etc/nginx/global/shopware.conf

# Configure supervisord
COPY conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Make sure files/folders needed by the processes are accessable when they run under the nobody user
RUN chown -R nobody.nobody /run && \
    chown -R nobody.nobody /var/lib/nginx && \
    chown -R nobody.nobody /var/tmp/nginx && \
    chown -R nobody.nobody /var/log/nginx

# Setup document root
RUN mkdir -p /var/www/html

# Add Shopware files
RUN mkdir -p /home/shopware_files 
ADD ./conf/download-sw.sh /home/shopware_files/download-sw.sh
RUN chmod +x /home/shopware_files/download-sw.sh && /home/shopware_files/download-sw.sh

# Add Opcache folder
RUN mkdir -p /var/www/html/.opcache

# 
RUN chown -R nobody.nobody /var/www/html

# Bind the Document Volume
VOLUME /var/www/html

# Switch to use a non-root user from here on
USER nobody

# Set work dir
WORKDIR /var/www/html

# Expose the port nginx is reachable on
EXPOSE 8080

# Let supervisord start nginx & php-fpm
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

# Configure a healthcheck to validate that everything is up&running
HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:8080/fpm-ping