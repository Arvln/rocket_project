rm -rf /var/log/mysql/mysql-bin.*
mysql -uroot -p123456
stop slave;
reset slave;
change master to master_host='172.18.0.2', master_port=3307, master_user='slave', master_password='slave',master_log_file='mysql-bin.000001', master_log_pos=590;
start slave;
show slave status \G;
