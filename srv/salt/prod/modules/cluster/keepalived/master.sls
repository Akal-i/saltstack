include:
  - modules.keepalived.install

master-conf-keepalived:
  file.managed:
    - source: salt://modules/cluster/keepalived/files/master.conf.j2
    - name: /etc/keepalived/keepalived.conf
    - template: jinja

master-keepalived.service:
  service.running:
    - name: keepalived.service
    - enable: true
