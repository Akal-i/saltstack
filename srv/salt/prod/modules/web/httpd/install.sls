"Development Tools":
  pkg.group_installed

apache_depend_package:
  pkg.installed:
    - pkgs:
      - openssl-devel
      - pcre-devel
      - expat-devel
      - libtool
      - gcc
      - gcc-c++
      - make

apache:
  user.present:
    - createhome: false
    - system: true
    - shell: /sbin/nologin

unzip-apr:
  archive.extracted:
    - name: /usr/src
    - source: salt://modules/web/httpd/files/apr-1.7.0.tar.gz

unzip-apr-util:
  archive.extracted:
    - name: /usr/src
    - source: salt://modules/web/httpd/files/apr-util-1.6.1.tar.gz

unzip-httpd:
  archive.extracted:
    - name: /usr/src
    - source: salt://modules/web/httpd/files/httpd-2.4.49.tar.gz

salt://modules/web/httpd/files/install.sh:
  cmd.script

/usr/include/httpd:
  file.symlink:
    - target: /usr/local/apache/include

/usr/local/apache/htdocs:
  file.directory:
    - user: apache
    - group: apache
    - mode: '0755'
    - recurse:
      - user
      - group

/usr/local/apache/conf/httpd.conf:
  file.managed:
    - source: salt://modules/web/httpd/files/httpd.conf
    - user: root
    - group: root
    - mode: '0644'

/usr/lib/systemd/system/httpd.service:
  file.managed:
    - user: root
    - group: root
    - mode: '0644'
    - source: salt://modules/web/httpd/files/httpd.service
