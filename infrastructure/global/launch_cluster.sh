source env_config.sh
source $ENV_REPO_PATH/$1.sh

gcloud config set project $PROJECT_NAME
gcloud config set compute/zone $ZONE

gcloud compute --project=$PROJECT_NAME networks create $NETWORK_NAME --subnet-mode=custom
gcloud compute --project=$PROJECT_NAME networks subnets create $SUBNETWORK_NAME --network=$NETWORK_NAME --region=$REGION --range=10.142.0.0/20

gcloud container clusters create $CLUSTER_NAME --enable-autoscaling --num-nodes 1 --min-nodes 1 --max-nodes 5 --subnetwork $SUBNETWORK_NAME --network $NETWORK_NAME --enable-ip-alias  --machine-type=e2-medium

gcloud compute addresses create $CLUSTER_NAME --region=$REGION

gcloud redis instances create $REDIS_NAME --size=1 --region=$REGION --zone=$ZONE --network=$NETWORK_NAME
 
gcloud sql instances create $SQL_INSTANCE_NAME --database-version=POSTGRES_9_6 --region=$REGION --cpu=$SQL_INSTANCE_CPU --memory=$SQL_INSTANCE_MEMORY

gcloud sql databases create $SQL_AUTH_DB_NAME --instance=$SQL_INSTANCE_NAME
gcloud sql databases create $SQL_INFO_DB_NAME --instance=$SQL_INSTANCE_NAME

gcloud sql users set-password $POSTGRES_WRITE_USER --instance=$SQL_INSTANCE_NAME --password="$POSTGRES_WRITE_USER_PASSWORD"

gcloud config set project $PROJECT_NAME
gcloud config set compute/zone $ZONE

mkdir -p $ADD_STORAGE_SECRET_FOLDER
