source env_config.sh
source $ENV_REPO_PATH/$1.sh

./infrastructure/global/switch_context.sh $1
./infrastructure/global/create_yaml_files_from_templates.sh $1

# Servers
kubectl apply -f ${YAML_FOLDER}/auth.yml
kubectl apply -f ${YAML_FOLDER}/sticky_auth.yml
kubectl apply -f ${YAML_FOLDER}/nglstate.yml
kubectl apply -f ${YAML_FOLDER}/ingress.yml
kubectl apply -f ${YAML_FOLDER}/info.yml
kubectl apply -f ${YAML_FOLDER}/schema.yml
kubectl apply -f ${YAML_FOLDER}/auth-info.yml
# Logging
kubectl apply -f ${YAML_FOLDER}/fluentd-custom-configmap.yml
kubectl apply -f ${YAML_FOLDER}/fluentd-custom-daemonset.yml
