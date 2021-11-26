include:
  - modules.cluster.keepalived.install

backup-conf-keepalived:
  file.managed:
    - source: salt://modules/cluster/keepalived/files/backup.conf.j2
    - name: /etc/keepalived/keepalived.conf
    - template: jinja

backup-keepalived.service:
  service.running:
    - name: keepalived.service
    - enable: true
