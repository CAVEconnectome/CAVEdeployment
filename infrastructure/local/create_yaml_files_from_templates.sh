source env_config.sh
source $ENV_REPO_PATH/$1.sh
source ./infrastructure/local/convert_variables.sh

mkdir -p ${YAML_FOLDER}
envsubst < kubetemplates/pcgl2cache.yml > ${YAML_FOLDER}/pcgl2cache.yml
envsubst < kubetemplates/skeletoncache.yml > ${YAML_FOLDER}/skeletoncache.yml
envsubst < kubetemplates/annotation.yml > ${YAML_FOLDER}/annotation.yml
envsubst < kubetemplates/ingress.yml > ${YAML_FOLDER}/ingress.yml
envsubst < kubetemplates/ingress-service.yml > ${YAML_FOLDER}/ingress-service.yml
envsubst < kubetemplates/materialize.yml > ${YAML_FOLDER}/materialize.yml
envsubst < kubetemplates/materialize_worker.yml > ${YAML_FOLDER}/materialize_worker.yml
envsubst < kubetemplates/materialize_migrations.yml > ${YAML_FOLDER}/materialize_migrations.yml
envsubst < kubetemplates/pychunkedgraph.yml > ${YAML_FOLDER}/pychunkedgraph.yml
envsubst < kubetemplates/meshing.yml > ${YAML_FOLDER}/meshing.yml
envsubst < kubetemplates/nglstate.yml > ${YAML_FOLDER}/nglstate.yml
envsubst < kubetemplates/mesh_worker.yml > ${YAML_FOLDER}/mesh_worker.yml
envsubst < kubetemplates/remesh_worker.yml > ${YAML_FOLDER}/remesh_worker.yml
# envsubst < kubetemplates/pychunkedgraph_cron.yml > ${YAML_FOLDER}/pychunkedgraph_cron.yml
# envsubst < kubetemplates/schema.yml > ${YAML_FOLDER}/schema.yml
envsubst < kubetemplates/secrets.yml > ${YAML_FOLDER}/secrets.yml
envsubst < kubetemplates/service-accounts.yml > ${YAML_FOLDER}/service-accounts.yml
envsubst < kubetemplates/fluentd-custom-configmap.yml > ${YAML_FOLDER}/fluentd-custom-configmap.yml
envsubst < kubetemplates/fluentd-custom-daemonset.yml > ${YAML_FOLDER}/fluentd-custom-daemonset.yml
envsubst < kubetemplates/nginx-ingress-helm-config.yml > ${YAML_FOLDER}/nginx-ingress-helm-config.yml
# envsubst < kubetemplates/nginx-ingress-helm-config_public.yml > ${YAML_FOLDER}/nginx-ingress-helm-config.yml
envsubst < kubetemplates/cert-issuer.yml > ${YAML_FOLDER}/cert-issuer.yml
envsubst < kubetemplates/cert-manager-values.yml > ${YAML_FOLDER}/cert-manager-values.yml
envsubst < kubetemplates/certificate.yml > ${YAML_FOLDER}/certificate.yml
envsubst < kubetemplates/proxy.yml > ${YAML_FOLDER}/proxy.yml
envsubst < kubetemplates/guidebook.yml > ${YAML_FOLDER}/guidebook.yml
envsubst < kubetemplates/tourguide.yml > ${YAML_FOLDER}/tourguide.yml
envsubst < kubetemplates/dash.yml > ${YAML_FOLDER}/dash.yml
envsubst < kubetemplates/auth-info.yml > ${YAML_FOLDER}/auth-info.yml
envsubst < kubetemplates/redis_production_values.yml > ${YAML_FOLDER}/redis_production_values.yml
envsubst < kubetemplates/meshing_pod_recycler.yml > ${YAML_FOLDER}/meshing_pod_recycler.yml
envsubst < kubetemplates/pprogress.yml > ${YAML_FOLDER}/pprogress.yml
envsubst < kubetemplates/pmanagement.yml > ${YAML_FOLDER}/pmanagement.yml
envsubst < kubetemplates/cavecanary.yml > ${YAML_FOLDER}/cavecanary.yml