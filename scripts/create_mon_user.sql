CREATE USER zbx_monitor WITH PASSWORD 'PGMonZBX' INHERIT;
GRANT pg_monitor TO zbx_monitor;