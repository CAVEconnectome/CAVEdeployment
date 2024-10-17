source env_config.sh
source $ENV_REPO_PATH/$1.sh

./infrastructure/local/switch_context.sh $1

./infrastructure/local/deploy_migration_job.sh $1


mkdir -p ${YAML_FOLDER}
envsubst < kubetemplates/$2.yml > ${YAML_FOLDER}/$2.yml
kubectl apply -f ${YAML_FOLDER}/$2.yml