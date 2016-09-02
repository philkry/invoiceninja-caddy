FROM alpine:edge
MAINTAINER philkry <philkry@gmx.de>

EXPOSE 80

RUN apk update && \
  apk --no-cache add tini \
    git \
	openssh-client \
    php5-fpm \
    php5-cli \
    php5-ctype \
    php5-curl \
    php5-dom \
    php5-gd \
    php5-iconv \
    php5-intl \
    php5-json \
    php5-mcrypt \
    php5-memcache \
    php5-mysql \
    php5-mysqli \
    php5-openssl \
    php5-pdo \
    php5-pdo_mysql \
    php5-pdo_pgsql \
    php5-pdo_sqlite \
    php5-pear \
    php5-pgsql \
    php5-phar \
    php5-sqlite3 \
    php5-xml \
    php5-zip \
    php5-zlib \
    php5-apcu \
	php5-gmp \
    sqlite \
	tar \
	caddy \
	bash \
	curl


RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


ENV INVOICENINJA_VERSION 2.6.10
ENV INVOICENINJA_TARBALL https://github.com/invoiceninja/invoiceninja/archive/v${INVOICENINJA_VERSION}.tar.gz

ADD ${INVOICENINJA_TARBALL} /tmp
RUN tar -xzf /tmp/v${INVOICENINJA_VERSION}.tar.gz --strip 1 -C /var/www && \
    rm /tmp/v${INVOICENINJA_VERSION}.tar.gz && \
    composer install --working-dir /var/www -o --no-dev --no-interaction --no-progress && \
    chown -R nobody:nobody /var/www 

#Copy over a default Caddyfile
COPY ./Caddyfile /etc/Caddyfile
COPY ./var/www/config/database.php /var/www/config/database.php


ENTRYPOINT ["/sbin/tini"]

CMD ["caddy", "--conf", "/etc/Caddyfile"]
