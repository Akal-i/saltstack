#include:
#  - modules.database.mysql.install
#  - bbs.grant-mysql
#  - modules.database.mysql.master

master-password:
  cmd.run:
    - name: {{ pillar['install_mysql_dir'] }}/mysql/bin/mysql -e "set password = password('{{ pillar["mysql_password"] }}');"
