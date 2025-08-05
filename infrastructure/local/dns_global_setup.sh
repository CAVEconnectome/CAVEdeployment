source env_config.sh
source ./infrastructure/local/defaults.sh
source $ENV_REPO_PATH/$1.sh
source ./infrastructure/local/convert_variables.sh

gcloud dns managed-zones create "${DNS_ZONE}" --dns-name="${DOMAIN_NAME}" --description="zone for ${DOMAIN_NAME}"