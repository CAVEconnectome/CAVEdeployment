source env_config.sh
source $ENV_REPO_PATH/$1.sh

helm upgrade -f $YAML_FOLDER/nginx-ingress-helm-config.yml ${NGINX_INGRESS_CONTROLLER_NAME} ingress-nginx/ingress-nginx --version ${NGINX_INGRESS_CHART_VERSION} --namespace kube-system
