grant-mysql:
  cmd.run:
    - name: {{ pillar['install_mysql_dir'] }}/mysql/bin/mysql -e "grant replication slave,super on *.* to 'repl'@'192.168.237.131' identified by 'repl123!';flush privileges;"
