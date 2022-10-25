source env_config.sh
source $ENV_REPO_PATH/$1.sh
kubectl delete -f $YAML_FOLDER/materialize_migrate.yml