{% if grains['osmajorrelease'] == '8' %}
ncurses-compat-libs:
  pkg.installed
{% endif %}

mysql:
  user.present:
    - createhome: false
    - system: true
    - shell: /sbin/nologin

{{ pillar['install_mysql_dir'] }}:
  archive.extracted:
    - source: salt://modules/database/mysql/files/mysql-5.7.34-linux-glibc2.12-x86_64.tar.gz
  file.symlink:
    - name: {{ pillar['install_mysql_dir'] }}/mysql
    - target: {{ pillar['install_mysql_dir'] }}/mysql-5.7.34-linux-glibc2.12-x86_64

{{ pillar['install_mysql_dir'] }}/mysql:
  file.directory:
    - user: mysql
    - group: mysql
    - mode: '0755'
    - recurse:
      - user
      - group
    - require:
      - file: {{ pillar['install_mysql_dir'] }}

/opt/data:
  file.directory:
    - user: mysql
    - group: mysql
    - mode: '0755'
    - makedirs: true
    - recurse:
      - user
      - group

/etc/my.cnf.d:
  file.directory:
    - user: root
    - group: root
    - mode: '0755'
    - makedirs: true
    - recurse:
      - user
      - group

/etc/profile.d/mysql.sh:
  file.managed:
    - user: root
    - group: root
    - mode: '0644'
    - source: salt://modules/database/mysql/files/mysql.sh.j2
    - template: jinja

/etc/ld.so.conf.d/mysql.conf:
  file.managed:
    - source: salt://modules/database/mysql/files/mysql.conf.j2
    - user: root
    - group: root
    - mode: '0644'
    - template: jinja

{{ pillar['install_mysql_dir'] }}/include/mysql:
  file.symlink:
    - target: {{ pillar['install_mysql_dir'] }}/mysql/include

/etc/my.cnf:
  file.managed:
    - source: salt://modules/database/mysql/files/my.cnf.j2
    - user: root
    - group: root
    - mode: '0644'
    - template: jinja

{{ pillar['install_mysql_dir'] }}/mysql/support-files/mysql.server:
  file.managed:
    - source: salt://modules/database/mysql/files/mysql.server.j2
    - user: mysql
    - group: mysql
    - mode: '0755'
    - template: jinja

/usr/lib/systemd/system/mysqld.service:
  file.managed:
    - source: salt://modules/database/mysql/files/mysqld.service.j2
    - user: root
    - group: root
    - mode: '0644'
    - template: jinja

initialize-mysql:
  cmd.run:
    - name: '{{ pillar['install_mysql_dir'] }}/mysql/bin/mysqld --initialize-insecure --user=mysql --datadir=/opt/data'
    - require:
      - user: mysql
      - archive: {{ pillar['install_mysql_dir'] }}
      - file: /opt/data
    - unless: test $(ls -l /opt/data | wc -l) -gt 1

mysqld.service:
  service.running:
    - enable: true
    - reload: true
    - watch: 
      - file: /etc/my.cnf
