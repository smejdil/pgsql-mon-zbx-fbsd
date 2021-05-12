# pgsql mon zbx fbsd

Easy script for setup Zabbix and PostgreSQL monitoring on FreeBSD

Tested: FreeBSD 13.0, Zabbix 5.0.11, PostgreSQL 12.6 + TimescaleDB 2.2.1

### Packages FreeBSD

- Package - py37-pip-20.2.3		Tool for installing and managing Python packages
- Package - py37-ansible-2.9.7		Radically simple IT automation

### How it works

Configure zabbix agent for PostgreSQL monitoring. https://git.zabbix.com/projects/ZBX/repos/zabbix/browse/templates/db/postgresql?at=refs%2Ftags%2F5.0.11 And ansible use collections 
https://galaxy.ansible.com/community/zabbix and by Zabbix API import PosgreSQL Template and 
update Zabbix server host.

- Python package - zabbix-api 0.5.4

### Install FreeBSD

```console
cd /usr/ports/devel/py-pip && make install clean
cd /usr/ports/sysutils/ansible && make install clean

pip install zabbix-api
```
### Install ansible collection zabbix

```console
ansible-galaxy collection install -r requirements.yml
Process install dependency map
Starting collection install process
Installing 'community.zabbix:1.3.0' to '/root/.ansible/collections/ansible_collections/community/zabbix'
```

### Run playbook
```console
export ZABBIX_USER=ansible
export ZABBIX_PASSWORD=*******************

setup-pgsql-monitoring.sh
```
### To do

- Configure zabbix agent by ansible