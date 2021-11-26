include:
  - modules.cluster.haproxy.install
  - modules.cluster.keepalived.install

haproxy-backup-conf-keepalived:
  file.managed:
    - source: salt://modules/cluster/haproxy/files/backup.conf.j2
    - name: /etc/keepalived/keepalived.conf
    - template: jinja

/scripts/notify.sh:
  fime.managed:
    - source: salt://modules/cluster/haproxy/files/notify.sh
    - mode: '0755'

backup-keepalived.service:
  service.running:
    - name: keepalived.service
    - enable: true
    - reload: true
    - watch:
      - file: haproxy-backup-conf-keepalived

stop-haproxy:
  service.dead:
    - name: haproxy.service
    - enable: false
