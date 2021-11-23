#include:
#  - modules.database.mysql.install
#  - modules.database.mysql.slave

#salt://bbs/files/start-slave.sh:
#  cmd.script

salve-password:
  cmd.run:
    - name: {{ pillar['install_mysql_dir'] }}/mysql/bin/mysql -e "set password = password('{{ pillar["mysql_password"] }}');"
