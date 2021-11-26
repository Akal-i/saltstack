include:
  - modules.cluster.haproxy.install
  - modules.cluster.keepalived.install

haproxy-master-conf-keepalived:
  file.managed:
    - source: salt://modules/cluster/haproxy/files/master.conf.j2
    - name: /etc/keepalived/keepalived.conf
    - template: jinja

/scripts/check_haproxy.sh:
  fime.managed:
    - source: salt://modules/cluster/haproxy/files/check_haproxy.sh
    - mode: '0755'

master-keepalived.service:
  service.running:
    - name: keepalived.service
    - enable: true
    - reload: true
    - watch:
      - file: haproxy-master-conf-keepalived
