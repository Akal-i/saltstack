php-depend-package:
  pkg.installed:
    - pkgs:
      - libxml2
      - libxml2-devel
      - openssl
      - openssl-devel
      - bzip2
      - bzip2-devel
      - libcurl
      - libcurl-devel
      - libicu-devel
      - libjpeg-turbo
      - libjpeg-turbo-devel
      - libpng
      - libpng-devel
      - openldap-devel
      - pcre-devel
      - freetype
      - freetype-devel
      - gmp
      - gmp-devel
      - libmcrypt
      - libmcrypt-devel
      - readline
      - readline-devel
      - libxslt
      - libxslt-devel
      - mhash
      - mhash-devel
      - php-mysqlnd
      - libsqlite3x-devel
      - libzip-devel

install-oniguruma-devel:
  cmd.run:
    - name: 'yum -y install http://mirror.centos.org/centos/8-stream/PowerTools/x86_64/os/Packages/oniguruma-devel-6.8.2-2.el8.x86_64.rpm'

/usr/src:
  archive.extracted:
    - source: salt://modules/application/php/files/php-7.4.24.tar.xz

salt://modules/application/php/files/install.sh:
  cmd.script

copy-file-php:
  file.managed:
    - names:
      - /usr/local/php7/etc/php-fpm.conf:
        - source: salt://modules/application/php/files/php-fpm.conf.default  
      - /usr/local/php7/etc/php-fpm.d/www.conf:
        - source: salt://modules/application/php/files/www.conf.default
      - /etc/php.ini:
        - source: salt://modules/application/php/files/php.ini-production
      - /etc/init.d/php-fpm:
        - source: salt://modules/application/php/files/init.d.php-fpm
        - user: root
        - group: root
        - mode: '0755'
      - /usr/lib/systemd/system/php-fpm.service:
        - source: salt://modules/application/php/files/php-fpm.service

php-fpm.service:
  service.running:
    - enable: true
