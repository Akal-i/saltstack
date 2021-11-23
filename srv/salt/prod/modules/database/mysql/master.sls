master-my.cnf:
  file.managed:
    - name: /etc/my.cnf.d/master.cnf
    - source: salt://modules/database/mysql/files/master-my.cnf
    - user: root
    - group: root
    - mode: '0644'

master-mysqld.service:
  service.running:
    - name: mysqld.service
    - enable: true
    - reload: true
    - watch:
      - file: master-my.cnf