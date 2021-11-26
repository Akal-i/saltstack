/etc/rsyslog.conf:
  file.managed:
    - source: salt://modules/cluster/haproxy/files/rsyslog.conf
    - user: root
    - group: root
    - mode: '0644'

stop-rsyslog:
  service.dead:
    - name: rsyslog

start-rsyslog:
  service.running:
    - name: rsyslog
