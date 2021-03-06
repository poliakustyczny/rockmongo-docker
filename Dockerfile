FROM php:7.2-apache

COPY rockmongo /var/www/html

WORKDIR /var/www/html

RUN apt-get update \
    && apt-get install -y \
        libcurl4-openssl-dev \
        pkg-config \
        libssl-dev \
        git \
        vim-tiny \
    && pecl install mongodb \
    && docker-php-ext-enable mongodb \
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === '93b54496392c062774670ac18b134c3b3a95e5a5e5c8f1a9f115f203b75bf9a129d5daa8ba6a13e2cc8a1da0806388a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && php composer.phar install

EXPOSE 80