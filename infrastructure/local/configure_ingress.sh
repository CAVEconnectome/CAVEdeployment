source environments/local/$1.sh

helm upgrade -f $YAML_FOLDER/nginx-ingress-helm-config.yml ${NGINX_INGRESS_CONTROLLER_NAME} ingress-nginx/ingress-nginx --version 3.4.1 --namespace kube-system
