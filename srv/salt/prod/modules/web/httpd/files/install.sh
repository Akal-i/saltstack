#!/bin/bash

cd /usr/src/apr-1.7.0/
sed -i '/$RM "$cfgfile"/d' configure
./configure --prefix=/usr/local/apr && make -j $(grep 'processor' /proc/cpuinfo | wc -l) && make install

cd ../apr-util-1.6.1/
./configure --prefix=/usr/local/apr-util --with-apr=/usr/local/apr && \
	make -j $(grep 'processor' /proc/cpuinfo | wc -l) && make install

cd ../httpd-2.4.49/
./configure --prefix=/usr/local/apache \
	--enable-so \
	--enable-ssl \
	--enable-cgi \
	--enable-rewrite \
	--with-zlib \
	--with-pcre \
	--with-apr=/usr/local/apr \
	--with-apr-util=/usr/local/apr-util/ \
	--enable-modules=most \
	--enable-mpms-shared=all \
	--with-mpm=prefork \
	&& make -j $(grep 'processor' /proc/cpuinfo | wc -l) && make install
