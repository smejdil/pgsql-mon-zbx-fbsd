#!/usr/local/bin/bash

# Copy sql files to zabbix dir
mkdir -p /var/lib/zabbix/postgresql
chown zabbix:zabbix /var/lib/zabbix/postgresql

INSTALL_DIR='/var/lib/zabbix/postgresql';

for i in `ls -1 postgresql/`; do
   install -g zabbix -o zabbix -m 644 postgresql/$i $INSTALL_DIR/
done

# Configure zabbix_agentd.conf
ZABBIX_ETC='/usr/local/etc/zabbix5';

sed -e "s/# Include=\/usr\/local\/etc\/zabbix5\/zabbix_agentd.conf.d\/\*.conf/Include=\/usr\/local\/etc\/zabbix5\/zabbix_agentd.conf.d\/\*.conf/" -i "" $ZABBIX_ETC/zabbix_agentd.conf

install -g zabbix -o zabbix -m 644 template_db_postgresql.conf $ZABBIX_ETC/zabbix_agentd.conf.d/

/usr/local/etc/rc.d/zabbix_agentd restart

# Create PG User
psql -h localhost -d template1 -a -q -f ./scripts/create_mon_user.sql

PG_VER=`pkg info | grep postgresql | grep server | awk 'BEGIN {FS="-"} {print substr($1,length($1)-1,2) }'`

cat pg_hba.conf >> /var/db/postgres/data${PG_VER}/pg_hba.conf

/usr/local/etc/rc.d/postgresql restart

# Import template & Update host Zabbix server

ansible-playbook setup-pgsql-monitoring.yml

# EOF
