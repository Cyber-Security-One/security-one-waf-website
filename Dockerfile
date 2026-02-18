FROM php:8.3-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git curl zip unzip libzip-dev libpng-dev libonig-dev libxml2-dev sqlite3 libsqlite3-dev nginx \
    && docker-php-ext-install pdo pdo_sqlite mbstring xml zip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

# Copy project files
COPY . .

# Install dependencies
RUN composer install --no-dev --optimize-autoloader --no-interaction
RUN npm install && npm run build

# Setup SQLite database
RUN touch database/database.sqlite

# Configure environment (only copy .env.example if .env doesn't exist)
RUN if [ ! -f .env ]; then cp .env.example .env; fi \
    && php artisan key:generate --no-interaction \
    && php artisan migrate --no-interaction

# Nginx config
RUN rm -f /etc/nginx/sites-enabled/default
COPY docker-nginx.conf /etc/nginx/sites-enabled/default

# Set permissions
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache /var/www/html/database

EXPOSE 80

# Start nginx + php-fpm
CMD php-fpm -D && nginx -g 'daemon off;'
