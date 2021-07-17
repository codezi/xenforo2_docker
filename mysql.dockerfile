FROM mysql:8.0.23

RUN echo 'default-authentication-plugin=mysql_native_password' >> /etc/mysql/my.cnf
RUN echo 'binlog_expire_logs_seconds=86400' >> /etc/mysql/my.cnf
RUN echo 'lower_case_table_names=1' >> /etc/mysql/my.cnf