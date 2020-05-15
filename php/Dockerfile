FROM php:7.4.2-fpm-alpine3.11

RUN apk update \
    && apk upgrade \
    && apk add --update bash zlib zlib-dev apache2 curl ca-certificates openssl openssh tzdata openntpd nano \
    php7-apache2 php7-phar php7-json php7-iconv php7-openssl freetype-dev libjpeg-turbo-dev libpng-dev

RUN docker-php-source extract
RUN docker-php-ext-install gd pdo pdo_mysql mysqli
RUN docker-php-ext-enable gd pdo pdo_mysql mysqli
RUN docker-php-source delete

RUN apk add shadow && usermod -u 1000 www-data && groupmod -g 1000 www-data
USER $USER

EXPOSE 9000

CMD ["php-fpm"]