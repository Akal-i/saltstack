redis_depend_package:
  pkg.installed:
    - pkgs:
      - systemd-devel
      - make
      - gcc
      - gcc-c++
      - tcl-devel

unzip-redis:
  archive.extracted:
    - source: salt://modules/database/redis/files/redis-6.0.6.tar.gz
    - name: /usr/src
    - if_missing: /usr/src/redis-6.0.6

redis-compile:
  cmd.run:
    - name: cd /usr/src/redis-6.0.6;make
    - unless: test -f /usr/bin/redis-server
    - require:
      - archive: unzip-redis

provide-program-file:
  file.managed:
    - names:
      - /usr/bin/redis-sentinel:
        - source: /usr/src/redis-6.0.6/src/redis-sentinel
      - /usr/bin/redis-server:
        - source: /usr/src/redis-6.0.6/src/redis-server
      - /usr/bin/redis-benchmark:
        - source: /usr/src/redis-6.0.6/src/redis-benchmark
      - /usr/bin/redis-check-aof:
        - source: /usr/src/redis-6.0.6/src/redis-check-aof
      - /usr/bin/redis-check-rdb:
        - source: /usr/src/redis-6.0.6/src/redis-check-rdb
      - /usr/bin/redis-cli:
        - source: /usr/src/redis-6.0.6/src/redis-cli
    - mode: '0755'

provide-config-file:
  file.managed:
    - names:
      - /etc/redis.conf:
        - source: salt://modules/database/redis/files/redis.conf.j2
        - template: jinja
      - /usr/lib/systemd/system/redis_server.service:
        - source: salt://modules/database/redis/files/redis_server.service

redis_server.service:
  service.running:
    - enable: true
    - reload: true
    - watch:
      - file: provide-config-file
