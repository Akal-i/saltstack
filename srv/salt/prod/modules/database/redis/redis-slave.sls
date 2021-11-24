include:
  - modules.database.redis.install

redis-slave.conf:
  file.managed:
    - name: /etc/redis.conf
    - source: salt://modules/database/redis/files/redis-slave.conf.j2

slave-start-redis:
  service.running:
    - enabled: true
    - reload: true
    - watch:
      - file: redis-slave.conf
