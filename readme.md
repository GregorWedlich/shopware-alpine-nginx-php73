## **Alpine Linux Lightweight container for Shopware 5**

**Based on Alpine Linux, Nginx and Mysql.**

Not for production!

Can use for theme creating and migration test's from other Shopsystems.

## **Enviroment Variables for PHP**

```
PHP.max_execution_time=30 // Shopware standard value
PHP.memory_limit=256M
PHP.upload_max_filesize=6M
PHP.post_max_size=8M
```

## **On browser**

http://localhost/ // for install and frontend

http://localhost/backend // backend

http://localhost:8082 // phpmyadmin

## **Extra mysql Settings for Migrating Data and other perfomance tuning**

```
/mysql_set/my-sw.cnf
```

## **Docker Compose**

```
docker-compose up -d
```

You can found themes folder under /public folder on your host. See more in composer file.

## **Docker commands**

```
docker network create -d bridge shopware_net
```

```
docker run --detach --env MYSQL_ROOT_PASSWORD=shopware --env MYSQL_USER=shopware --env MYSQL_PASSWORD=shopware --env MYSQL_DATABASE=shopware --env TZ=Europe/Berlin --name shopware_db --net=shopware_net --publish 3306:3306 mysql:5.7
```

```
docker run -p 80:8080 -e PHP.max_execution_time=120 --env MYSQL_DATABASE=shopware --env MYSQL_USER=shopware --env MYSQL_PASSWORD=shopware --env MYSQL_HOST=shopware_db --env TZ=Europe/Berlin --net=shopware_net prinzmonty/shopware-nginx-php73
```

You can use TAG's for diferent Shopware Versions like "prinzmonty/shopware-nginx-php73:5.6.2"
