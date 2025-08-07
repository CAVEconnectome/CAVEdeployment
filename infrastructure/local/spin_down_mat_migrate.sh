source env_config.sh
source ./infrastructure/local/defaults.sh
source $ENV_REPO_PATH/$1.sh
source ./infrastructure/local/convert_variables.sh

kubectl delete -f $YAML_FOLDER/materialize_migrate.yml