#!/bin/bash
# Usage: ./upgrade_postgis.sh [-h host] [-U user] [-p port]

PSQL_OPTS="$@"

psql $PSQL_OPTS -Atc "
  SELECT datname FROM pg_database
  WHERE datistemplate = false
    AND datallowconn = true
  ORDER BY datname;
" | while IFS= read -r dbname; do
  echo "==> $dbname"
  psql $PSQL_OPTS -d "$dbname" -c "SELECT postgis_extensions_upgrade();"
done