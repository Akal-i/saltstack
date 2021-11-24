include:
  - modules.database.redis.install

redis-master.conf:
  file.managed:
    - name: /etc/redis.conf
    - source: salt://modules/database/redis/files/redis-master.conf.j2

master-start-redis:
  service.running:
    - enabled: true
    - reload: true
    - watch:
      - file: redis-master.conf
