source env_config.sh
source ./infrastructure/local/defaults.sh
source $ENV_REPO_PATH/$1.sh
source ./infrastructure/local/convert_variables.sh

./infrastructure/local/switch_context.sh $1

# helm repo add bitnami https://charts.bitnami.com/bitnami
# helm install redis-release  bitnami/redis --values ${YAML_FOLDER}/redis_production_values.yml --version 17.11.2 

# helm upgrade --force --recreate-pods -f ${YAML_FOLDER}/redis_production_values.yml redis-release bitnami/redis  --version 10.7.11

helm repo add zettaai http://zetta.ai/helm-charts/charts
helm repo update
helm install meshing.recycler zettaai/simple-cronjob -f ${YAML_FOLDER}/meshing_pod_recycler.yml

# helm upgrade --force --recreate-pods -f ${YAML_FOLDER}/meshing_pod_recycler.yml meshing.recycler zettaai/simple-cronjob