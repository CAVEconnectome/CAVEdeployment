source environments/local/$1.sh

./infrastructure/local/switch_context.sh $1
./infrastructure/local/create_yaml_files_from_templates.sh $1

helm upgrade --recreate-pods -f ${YAML_FOLDER}/redis_production_values.yml redis-release bitnami/redis  --version 10.7.11
