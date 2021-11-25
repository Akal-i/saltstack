redis_install_dir: /usr/local
redis_pass: 123456
master_ip: 192.168.237.137
slave_ip: 192.168.237.131
redis_sentinel_port: 26379
sentinel_name: mymaster
sentinel_monitor_target: 192.168.237.137 6379 2
sentinel_failover_timeout: 180000
