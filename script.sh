#!/bin/sh

cp $PHP_INI_DIR/php.ini-production $PHP_INI_DIR/php.ini
sed -i 's|;sendmail_path =|sendmail_path = "msmtp -t"|' $PHP_INI_DIR/php.ini
    