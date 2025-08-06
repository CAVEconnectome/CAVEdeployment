source env_config.sh
source ./infrastructure/local/defaults.sh
source $ENV_REPO_PATH/$1.sh
source ./infrastructure/local/convert_variables.sh

helm upgrade -f $YAML_FOLDER/nginx-ingress-helm-config.yml ${NGINX_INGRESS_CONTROLLER_NAME} ingress-nginx/ingress-nginx --version 4.1.2 --namespace kube-system
