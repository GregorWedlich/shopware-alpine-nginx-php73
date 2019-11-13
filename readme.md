docker run --detach --env MYSQL_ROOT_PASSWORD=shopware --env MYSQL_USER=shopware --env MYSQL_PASSWORD=shopware --env MYSQL_DATABASE=shopware --name shopware_db --net=shopware_net --publish 3306:3306 mysql:5.7

docker run -p 80:8080 -e PHP.max_execution_time=120 --env MYSQL_DATABASE=shopware --env MYSQL_USER=shopware --env MYSQL_PASSWORD=shopware --env MYSQL_HOST=shopware_db --net=shopware_net prinzmonty/shopware-nginx-php73
