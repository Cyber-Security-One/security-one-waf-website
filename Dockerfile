FROM alpine:3.21

# Install pre-compiled PHP 8.3, extensions, Nginx, Node.js — no compilation needed
RUN apk add --no-cache \
    php83 php83-fpm php83-pdo php83-pdo_sqlite php83-mbstring php83-xml php83-zip \
    php83-tokenizer php83-ctype php83-fileinfo php83-session php83-dom php83-openssl \
    php83-phar php83-iconv php83-curl php83-sqlite3 \
    nginx nodejs npm git curl zip unzip \
    && ln -sf /usr/bin/php83 /usr/bin/php

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

# Copy project files
COPY . .

# Install dependencies
RUN composer install --no-dev --optimize-autoloader --no-interaction
RUN npm install && npm run build

# Setup SQLite database
RUN touch database/database.sqlite

# Configure environment
RUN if [ ! -f .env ]; then cp .env.example .env; fi \
    && php artisan key:generate --no-interaction \
    && php artisan migrate --no-interaction

# Nginx config
COPY docker-nginx.conf /etc/nginx/http.d/default.conf

# Fix PHP-FPM config to listen on 127.0.0.1:9000
RUN sed -i 's|listen = 127.0.0.1:9000|listen = 127.0.0.1:9000|g' /etc/php83/php-fpm.d/www.conf \
    && sed -i 's|;clear_env = no|clear_env = no|g' /etc/php83/php-fpm.d/www.conf

# Create required directories
RUN mkdir -p /run/nginx /var/log/php83

# Set permissions
RUN chown -R nobody:nobody /var/www/html/storage /var/www/html/bootstrap/cache /var/www/html/database

EXPOSE 80

# Start nginx + php-fpm
CMD php-fpm83 -D && nginx -g 'daemon off;'
