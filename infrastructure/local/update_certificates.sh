source env_config.sh
source $ENV_REPO_PATH/$1.sh
source ./infrastructure/local/convert_variables.sh

./infrastructure/local/switch_context.sh $1
./infrastructure/local/create_yaml_files_from_templates.sh $1

kubectl apply -f ${YAML_FOLDER}/certificate.yml

sleep 300