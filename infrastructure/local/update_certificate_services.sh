source env_config.sh
source ./infrastructure/local/defaults.sh
source $ENV_REPO_PATH/$1.sh
source ./infrastructure/local/convert_variables.sh

./infrastructure/local/create_yaml_files_from_templates.sh $1

# DNS CERTIFICATES
kubectl apply -f ${YAML_FOLDER}/cert-issuer.yml

sleep 100

kubectl apply -f ${YAML_FOLDER}/certificate.yml

sleep 300