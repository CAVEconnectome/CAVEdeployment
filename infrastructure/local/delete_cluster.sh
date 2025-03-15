source env_config.sh
source $ENV_REPO_PATH/$1.sh
source ./infrastructure/local/convert_variables.sh

if [ "$#" == 1 ]; then
    gcloud container clusters delete $CLUSTER_NAME
    gcloud compute addresses delete $CLUSTER_NAME --region=$REGION

    gcloud compute addresses delete --global $(gcloud compute addresses list --filter="${NETWORK_NAME}" --format="value(name)")

    # gcloud redis instances delete $REDIS_NAME --region=$REGION

    gcloud compute --project=$PROJECT_NAME networks subnets delete $SUBNETWORK_NAME  --region=$REGION
    gcloud compute --project=$PROJECT_NAME firewall-rules delete $(gcloud compute firewall-rules list --filter="network=${NETWORK_NAME}" --format="value(name)")
    gcloud compute --project=$PROJECT_NAME networks delete $NETWORK_NAME

    gcloud iam service-accounts --project=$PROJECT_NAME delete "${AE_SERVICE_ACCOUNT_NAME}@${PROJECT_NAME}.iam.gserviceaccount.com"
    gcloud iam service-accounts --project=$PROJECT_NAME delete "${CLOUD_SQL_SERVICE_ACCOUNT_NAME}@${PROJECT_NAME}.iam.gserviceaccount.com"
    gcloud iam service-accounts --project=$PROJECT_NAME delete "${CLOUD_DNS_SERVICE_ACCOUNT_NAME}@${PROJECT_NAME}.iam.gserviceaccount.com"
    gcloud iam service-accounts --project=$PROJECT_NAME delete "${PYCG_SERVICE_ACCOUNT_NAME}@${PROJECT_NAME}.iam.gserviceaccount.com"
fi