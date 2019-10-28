FROM debian:stretch-slim

RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get install -y curl unzip

RUN apt-get install -y php-common php-cli php-gd php-mbstring php-mcrypt php-zip php-opcache php-xml php-curl

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

WORKDIR /home

RUN composer create-project laravel/lumen blog "5.1.*"

WORKDIR /home/blog

EXPOSE 8000

# RUN php -S localhost:8000 -t public

# CMD ["bash"]

CMD ["php", "-S", "localhost:8000", "-t", "public"]