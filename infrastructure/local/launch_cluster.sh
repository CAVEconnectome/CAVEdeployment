source env_config.sh
source $ENV_REPO_PATH/$1.sh

gcloud config set project $PROJECT_NAME
gcloud config set compute/zone $ZONE

gcloud compute --project=$PROJECT_NAME networks create $NETWORK_NAME --subnet-mode=custom
gcloud compute --project=$PROJECT_NAME networks subnets create $SUBNETWORK_NAME --network=$NETWORK_NAME --region=$REGION --range=10.142.0.0/20

gcloud container clusters create $CLUSTER_NAME --enable-autoscaling --num-nodes 1 --min-nodes 1 --max-nodes 1 --subnetwork $SUBNETWORK_NAME --network $NETWORK_NAME --enable-ip-alias  --machine-type=e2-standard-2

gcloud redis instances create $PCG_REDIS_NAME --size=1 --project=$PROJECT_NAME --region=$REGION --zone=$ZONE --network=$NETWORK_NAME --redis-config maxmemory-policy=allkeys-lru --redis-config maxmemory-gb=0.98
gcloud redis instances create $MAT_REDIS_NAME --size=1 --project=$PROJECT_NAME --region=$REGION --zone=$ZONE --network=$NETWORK_NAME --redis-config maxmemory-policy=allkeys-lru


# TODO add more configuration details for node pool creation here (pre-emptible, etc)
gcloud container node-pools create $STANDARD_POOL --cluster $CLUSTER_NAME --node-taints pool=$STANDARD_POOL:NoSchedule --enable-autoscaling --num-nodes 1 --min-nodes 1 --max-nodes 10 --machine-type=t2d-standard-4 --disk-size=20GB
# gcloud container node-pools create $CELERY_WORKER_POOL --cluster $CLUSTER_NAME --node-taints pool=$CELERY_WORKER_POOL:NoSchedule --num-nodes 1 --enable-autoscaling --min-nodes 1 --max-nodes 4  --machine-type=e2-highcpu-8 --disk-size=20GB
gcloud container node-pools create $LIGHTWEIGHT_POOL --cluster $CLUSTER_NAME --node-taints pool=$LIGHTWEIGHT_POOL:NoSchedule --num-nodes 1 --preemptible --enable-autoscaling --min-nodes 1 --max-nodes 10  --machine-type=e2-small --disk-size=20GB
gcloud container node-pools create $MESH_POOL --cluster $CLUSTER_NAME --node-taints pool=$MESH_POOL:NoSchedule --num-nodes 1 --preemptible --enable-autoscaling --min-nodes 1 --max-nodes 100 --disk-size=20GB --machine-type t2d-standard-4
gcloud container node-pools create $CORE_POOL --cluster $CLUSTER_NAME --num-nodes 1 --enable-autoscaling --min-nodes 1 --max-nodes 4  --machine-type=e2-standard-2 --disk-size=20GB
gcloud container node-pools delete default-pool --cluster $CLUSTER_NAME

gcloud compute addresses create $CLUSTER_NAME --region=$REGION

gcloud sql instances create $SQL_INSTANCE_NAME --database-version=POSTGRES_13 --region=$REGION --cpu=$SQL_INSTANCE_CPU --memory=$SQL_INSTANCE_MEMORY

gcloud sql databases create $SQL_ANNO_DB_NAME --instance=$SQL_INSTANCE_NAME
gcloud sql databases create $SQL_MAT_DB_NAME --instance=$SQL_INSTANCE_NAME

gcloud sql users set-password $POSTGRES_WRITE_USER --instance=$SQL_INSTANCE_NAME --password="$POSTGRES_WRITE_USER_PASSWORD"

kubectl create clusterrolebinding cluster-admin-binding --clusterrole cluster-admin --user "$(gcloud config get-value account)"
kubectl apply -f https://raw.githubusercontent.com/GoogleCloudPlatform/k8s-stackdriver/master/custom-metrics-stackdriver-adapter/deploy/production/adapter.yaml

mkdir -p $ADD_STORAGE_SECRET_FOLDER

./infrastructure/local/configure_pubsub.sh $1
