FROM composer:2.5 as build

COPY . /app/
WORKDIR /app
# RUN rm composer.lock
# RUN composer install --prefer-dist --optimize-autoloader --no-interaction
RUN composer install

# install node
#RUN curl -sL https://deb.nodesource.com/setup_16.x -o nodesource_setup.sh
#RUN bash nodesource_setup.sh
#RUN apt-get install -y nodejs
#RUN rm nodesource_setup.sh
RUN apk add --update nodejs npm

# Install dependencies and build the app
RUN npm install
RUN npm run build


FROM php:8.1-apache-buster as production

#ENV APP_ENV=production
ENV APP_DEBUG=false

RUN docker-php-ext-configure opcache --enable-opcache && \
  docker-php-ext-install pdo pdo_mysql

COPY docker/opcache.ini /usr/local/etc/php/conf.d/opcache.ini

COPY --from=build /app /var/www/html
COPY docker/000-default.conf /etc/apache2/sites-available/000-default.conf
#COPY .env.prod /var/www/html/.env

# Install composer

#RUN composer install

#RUN php artisan key:generate

RUN php artisan config:cache && \
  php artisan route:cache && \
  chmod 777 -R /var/www/html/storage/ && \
  chown -R www-data:www-data /var/www/ && \
  a2enmod rewrite