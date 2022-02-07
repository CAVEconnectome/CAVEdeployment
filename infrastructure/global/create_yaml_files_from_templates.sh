source env_config.sh
source $ENV_REPO_PATH/$1.sh

mkdir -p ${YAML_FOLDER}
envsubst < kubetemplates/auth.yml > ${YAML_FOLDER}/auth.yml
envsubst < kubetemplates/sticky_auth.yml > ${YAML_FOLDER}/sticky_auth.yml
envsubst < kubetemplates/nglstate.yml > ${YAML_FOLDER}/nglstate.yml
envsubst < kubetemplates/info.yml > ${YAML_FOLDER}/info.yml
envsubst < kubetemplates/schema.yml > ${YAML_FOLDER}/schema.yml
envsubst < kubetemplates/auth-info.yml > ${YAML_FOLDER}/auth-info.yml

envsubst < kubetemplates/auth_ingress.yml > ${YAML_FOLDER}/ingress.yml
envsubst < kubetemplates/secrets.yml > ${YAML_FOLDER}/secrets.yml
envsubst < kubetemplates/service-accounts.yml > ${YAML_FOLDER}/service-accounts.yml
envsubst < kubetemplates/fluentd-custom-configmap.yml > ${YAML_FOLDER}/fluentd-custom-configmap.yml
envsubst < kubetemplates/fluentd-custom-daemonset.yml > ${YAML_FOLDER}/fluentd-custom-daemonset.yml
envsubst < kubetemplates/nginx-ingress-helm-config.yml > ${YAML_FOLDER}/nginx-ingress-helm-config.yml
envsubst < kubetemplates/cert-issuer.yml > ${YAML_FOLDER}/cert-issuer.yml
envsubst < kubetemplates/cert-manager-values.yml > ${YAML_FOLDER}/cert-manager-values.yml
envsubst < kubetemplates/certificate.yml > ${YAML_FOLDER}/certificate.yml
