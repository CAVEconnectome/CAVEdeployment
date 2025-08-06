source env_config.sh
source ./infrastructure/local/defaults.sh
source $ENV_REPO_PATH/$1.sh

./infrastructure/local/switch_context.sh $1

source $ENV_REPO_PATH/$1.sh

gcloud container clusters get-credentials $CLUSTER_NAME --zone $ZONE

kubectl delete secret $PYCG_SERVICE_ACCOUNT_SECRET
kubectl create secret generic $PYCG_SERVICE_ACCOUNT_SECRET --from-file=${GOOGLE_SECRET_FILENAME}=${KEY_FOLDER}/${PYCG_SERVICE_ACCOUNT_NAME}.json $PYCG_SERVICE_ACCOUNT_ADDON \
    --from-file=${CAVE_SECRET_FILENAME}=${ADD_STORAGE_SECRET_FOLDER}/${CAVE_SECRET_FILENAME} 
    
kubectl delete secret $SKELETON_SERVICE_ACCOUNT_SECRET
kubectl create secret generic $SKELETON_SERVICE_ACCOUNT_SECRET --from-file=${GOOGLE_SECRET_FILENAME}=${KEY_FOLDER}/${SKELETON_SERVICE_ACCOUNT_NAME}.json \
    --from-file=${CAVE_SECRET_FILENAME}=${ADD_STORAGE_SECRET_FOLDER}/${CAVE_SECRET_FILENAME} 
    
kubectl delete secret $AE_SERVICE_ACCOUNT_SECRET
kubectl create secret generic $AE_SERVICE_ACCOUNT_SECRET --from-file=${GOOGLE_SECRET_FILENAME}=${KEY_FOLDER}/${AE_SERVICE_ACCOUNT_NAME}.json  \
    --from-file=${CAVE_SECRET_FILENAME}=${ADD_STORAGE_SECRET_FOLDER}/${CAVE_SECRET_FILENAME}

kubectl delete secret $CLOUD_SQL_SERVICE_ACCOUNT_SECRET
kubectl create secret generic $CLOUD_SQL_SERVICE_ACCOUNT_SECRET --from-file=${GOOGLE_SECRET_FILENAME}=${KEY_FOLDER}/${CLOUD_SQL_SERVICE_ACCOUNT_NAME}.json

kubectl delete secret $CLOUD_DNS_SERVICE_ACCOUNT_SECRET
kubectl create secret generic $CLOUD_DNS_SERVICE_ACCOUNT_SECRET --from-file=${GOOGLE_SECRET_FILENAME}=${KEY_FOLDER}/${CLOUD_DNS_SERVICE_ACCOUNT_NAME}.json

kubectl delete secret $PMANAGEMENT_SERVICE_ACCOUNT_SECRET
kubectl create secret generic $PMANAGEMENT_SERVICE_ACCOUNT_SECRET --from-file=${GOOGLE_SECRET_FILENAME}=${KEY_FOLDER}/${PMANAGEMENT_SERVICE_ACCOUNT_NAME}.json \
    --from-file=${CAVE_SECRET_FILENAME}=${ADD_STORAGE_SECRET_FOLDER}/${PMANAGEMENT_SECRET_FILENAME} 