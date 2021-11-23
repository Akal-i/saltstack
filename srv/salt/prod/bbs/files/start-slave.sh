#!/bin/bash

mysql=/usr/local/mysql/bin/mysql
master_ip=192.168.237.169
repl_user=repl
repl_passwd=repl123!
log_file=$($mysql -u$repl_user -p$repl_passwd -h$master_ip -e 'show master status\G' |awk 'NR==2{print $2}')
log_pos=$($mysql -u$repl_user -p$repl_passwd -h$master_ip -e 'show master status\G' |awk 'NR==3{print $2}')

$mysql -e "change master to MASTER_HOST='$master_ip',MASTER_USER='$repl_user',MASTER_PASSWORD='$repl_passwd',MASTER_LOG_FILE='$log_file',MASTER_LOG_POS=$log_pos;start slave;"
