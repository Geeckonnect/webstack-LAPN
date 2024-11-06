# Use Debian 12 Slim
FROM debian:12-slim

# Set environment variables for versions
ARG PHP_VERSION=8.1
ARG NODE_VERSION=20

# Install system dependencies and necessary tools
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    curl \
    gnupg \
    lsb-release \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Add the sury repository to install PHP 8.1
RUN curl -fsSL https://packages.sury.org/php/apt.gpg | gpg --dearmor -o /usr/share/keyrings/sury-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/sury-archive-keyring.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/sury-php.list && \
    apt-get update

# Install Apache, PHP-FPM, and required PHP extensions
RUN apt-get update && apt-get install -y \
    apache2 \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-zip \
    php${PHP_VERSION}-intl \
    php${PHP_VERSION}-gd \
    php${PHP_VERSION}-opcache \
    php${PHP_VERSION}-bcmath \
    php${PHP_VERSION}-mysql \
    && rm -rf /var/lib/apt/lists/*

# Configure Apache to use PHP-FPM and enable mod_rewrite
RUN a2enmod rewrite proxy_fcgi setenvif
RUN a2enconf php${PHP_VERSION}-fpm

# Recommended PHP configurations
RUN echo "memory_limit=512M" > /etc/php/${PHP_VERSION}/fpm/conf.d/90-custom.ini && \
    echo "upload_max_filesize=10M" >> /etc/php/${PHP_VERSION}/fpm/conf.d/90-custom.ini && \
    echo "post_max_size=12M" >> /etc/php/${PHP_VERSION}/fpm/conf.d/90-custom.ini && \
    echo "max_execution_time=60" >> /etc/php/${PHP_VERSION}/fpm/conf.d/90-custom.ini && \
    echo "opcache.enable=1" >> /etc/php/${PHP_VERSION}/fpm/conf.d/90-custom.ini

# Install Node.js and npm
RUN curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g npm@latest

# Create a test index.php file
RUN echo "<?php phpinfo(); ?>" > /var/www/html/index.php

# Expose the HTTP port
EXPOSE 80

# Copy the start script into the container
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Set the entrypoint to the start script
ENTRYPOINT ["/start.sh"]

