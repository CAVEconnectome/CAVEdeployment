source environments/global/$1.sh

./infrastructure/global/switch_context.sh $1

kubectl delete secret $CLOUD_SQL_SERVICE_ACCOUNT_SECRET
kubectl create secret generic $CLOUD_SQL_SERVICE_ACCOUNT_SECRET --from-file=${GOOGLE_SECRET_FILENAME}=${KEY_FOLDER}/${CLOUD_SQL_SERVICE_ACCOUNT_NAME}.json \

kubectl delete secret $INFOSERVICE_SERVICE_ACCOUNT_SECRET
kubectl create secret generic $INFOSERVICE_SERVICE_ACCOUNT_SECRET --from-file=${CAVE_SECRET_FILENAME}=${ADD_STORAGE_SECRET_FOLDER}/${CAVE_SECRET_FILENAME} 

kubectl delete secret $AUTH_SERVICE_ACCOUNT_SECRET
kubectl create secret generic $AUTH_SERVICE_ACCOUNT_SECRET --from-file=${GOOGLE_SECRET_FILENAME}=${KEY_FOLDER}/${AUTH_SERVICE_ACCOUNT_NAME}.json

kubectl delete secret $NGLSTATE_SERVICE_ACCOUNT_SECRET
kubectl create secret generic $NGLSTATE_SERVICE_ACCOUNT_SECRET --from-file=${GOOGLE_SECRET_FILENAME}=${KEY_FOLDER}/${NGLSTATE_SERVICE_ACCOUNT_NAME}.json

kubectl delete secret $AUTH_OAUTH_SECRET
kubectl create secret generic $AUTH_OAUTH_SECRET --from-file=${OAUTH_SECRET_FILENAME}=${KEY_FOLDER}/${OAUTH_SECRET_FILENAME}

kubectl delete secret $CLOUD_DNS_SERVICE_ACCOUNT_SECRET
kubectl create secret generic $CLOUD_DNS_SERVICE_ACCOUNT_SECRET --from-file=${GOOGLE_SECRET_FILENAME}=${KEY_FOLDER}/${CLOUD_DNS_SERVICE_ACCOUNT_NAME}.json
