slave-my.cnf:
  file.managed:
    - name: /etc/my.cnf.d/slave.cnf
    - source: salt://modules/database/mysql/files/slave-my.cnf
    - user: root
    - group: root
    - mode: '0644'

slave-mysqld.service:
  service.running:
    - name: mysqld.service
    - enable: true
    - reload: true
    - watch:
      - file: slave-my.cnf
