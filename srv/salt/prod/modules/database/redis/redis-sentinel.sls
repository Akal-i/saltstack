include:
  - modules.database.redis.install

{{ pillar['redis_install_dir'] }}/conf/sentinel.conf:
  file.managed:
    - source: salt://modules/database/redis/files/sentinel.conf.j2
    - user: root
    - group: root
    - template: jinja

start-sentinel:
  cmd.run:
    - name: /usr/bin/redis-sentinel {{ pillar['redis_install_dir'] }}/conf/sentinel.conf
