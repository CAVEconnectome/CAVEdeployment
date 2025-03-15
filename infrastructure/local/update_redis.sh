source env_config.sh
source $ENV_REPO_PATH/$1.sh
source ./infrastructure/local/convert_variables.sh

./infrastructure/local/switch_context.sh $1
./infrastructure/local/create_yaml_files_from_templates.sh $1

helm  upgrade -f ${YAML_FOLDER}/redis_production_values.yml redis-release bitnami/redis --version 17.11.2 