# Use Ubuntu 16.04 LTS as the base image
FROM ubuntu:16.04

# Install software-properties-common to add repositories
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    apt-get clean

# Add the ondrej/php repository which contains PHP 7.0 packages
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php

# Update package lists again
RUN apt-get update

# Install Apache, PHP 7.0, git, zip, unzip, curl, Composer, and required PHP extensions
RUN apt-get install -y apache2 php7.0 libapache2-mod-php7.0 php7.0-mysql php7.0-mysqli php7.0-mbstring php7.0-xml git php7.0-zip php7.0-mcrypt php7.0-curl && \
    apt-get clean

# Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    php -r "unlink('composer-setup.php');"

# Enable Apache modules
RUN a2enmod rewrite

# Expose port
EXPOSE 80

# Start Apache in the foreground
CMD ["apache2ctl", "-D", "FOREGROUND"]
