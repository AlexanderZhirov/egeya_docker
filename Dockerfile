ARG PHP_VERSION
FROM php:${PHP_VERSION}-apache

RUN apt-get update \
    && apt-get install -y libpng-dev libjpeg-dev libmcrypt-dev libzip-dev unzip git msmtp \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-install gd mbstring mysqli pdo_mysql zip
RUN a2enmod rewrite actions

# Copy the settings file mSMTP
COPY msmtprc /etc/msmtprc
RUN chmod 600 /etc/msmtprc

# Change the default mail sending server in php.ini
COPY script.sh /tmp/script.sh
RUN chmod +x /tmp/script.sh \
    && /tmp/script.sh
    
ARG AEGEYA_VERSION
ENV DIST e2_distr_v${AEGEYA_VERSION}.zip
ENV URL https://blogengine.ru/download/${DIST}
RUN curl -O ${URL} \
    && unzip ${DIST} -d /var/www/html

EXPOSE 80
