source env_config.sh
source ./infrastructure/local/defaults.sh
source $ENV_REPO_PATH/$1.sh
source ./infrastructure/local/convert_variables.sh

gcloud redis instances create $PCG_REDIS_NAME --size=1 --project=$PROJECT_NAME --region=$REGION --zone=$ZONE --network=$NETWORK_NAME --redis-config maxmemory-policy=allkeys-lru
