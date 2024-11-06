#!/bin/bash

# Start PHP-FPM
service php8.1-fpm start

# Start Apache in the foreground
apache2ctl -D FOREGROUND

