FROM php:8.0.2-fpm

COPY xenforo/ /var/www/html/

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN apt-get update \
    && apt-get install unzip \
    && apt-get install -y zlib1g-dev \
    && apt-get install -y libzip-dev libgmp-dev

RUN docker-php-ext-install mysqli \ 
	&& docker-php-ext-install pdo_mysql \
	&& docker-php-ext-install zip

# XenForo2 required extension GMP
RUN docker-php-ext-configure gmp && docker-php-ext-install gmp

# install php GD & Imagick ext
RUN apt-get install -y --no-install-recommends \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    zlib1g-dev \
    libpng-dev \
    libjpeg-dev \
    libmagickwand-dev

# PHP 8 does not include pecl so switch to new module manager pickle
RUN curl -L --output /tmp/pickle.phar https://github.com/FriendsOfPHP/pickle/releases/download/v0.7.0/pickle.phar \
    && mv /tmp/pickle.phar /usr/local/bin/pickle \
    && chmod +x /usr/local/bin/pickle

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j "$(nproc)" gd

# install imagick
# use github version for now until release from https://pecl.php.net/get/imagick is ready for PHP 8
RUN mkdir -p /usr/src/php/ext/imagick; \
    curl -fsSL https://github.com/Imagick/imagick/archive/448c1cd0d58ba2838b9b6dff71c9b7e70a401b90.tar.gz | tar xvz -C "/usr/src/php/ext/imagick" --strip 1; \
    docker-php-ext-install imagick

# https://github.com/xfrocks/DevHelper/blob/xf2/Dockerfile
RUN composer global require \
        phpstan/phpstan:0.12.38 \
        phpstan/phpstan-strict-rules:0.12.4 \
        friendsofphp/php-cs-fixer \
        && mv /root/.composer/vendor /etc/devhelper-composer-vendor

RUN apt-get install -y nodejs \
	&& apt-get install -y build-essential \
	&& curl https://www.npmjs.com/install.sh | sh

# Install https://github.com/mishoo/UglifyJS2 global
RUN npm install uglify-js -g && npm install prettier -g

COPY ./addons/DevHelper/docker /temp/scripts
COPY ./scripts /temp/scripts

RUN chmod a+x /temp/scripts/*

ENV PATH="/temp/scripts:/root/.composer/vendor/bin:${PATH}"

WORKDIR "/var/www/html/src/addons"