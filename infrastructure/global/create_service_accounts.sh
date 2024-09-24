source env_config.sh
source $ENV_REPO_PATH/$1.sh

mkdir -p ${KEY_FOLDER}
gcloud iam service-accounts create $CLOUD_SQL_SERVICE_ACCOUNT_NAME --display-name=CloudSQL-$ENVIRONMENT
gcloud projects add-iam-policy-binding $PROJECT_NAME --member serviceAccount:$CLOUD_SQL_SERVICE_ACCOUNT_NAME@$PROJECT_NAME.iam.gserviceaccount.com --role roles/cloudsql.client

gcloud iam service-accounts create $AUTH_SERVICE_ACCOUNT_NAME --display-name=Auth-$ENVIRONMENT
gcloud projects add-iam-policy-binding $PROJECT_NAME --member serviceAccount:$AUTH_SERVICE_ACCOUNT_NAME@$PROJECT_NAME.iam.gserviceaccount.com --role roles/redis.editor

gcloud iam service-accounts create $NGLSTATE_SERVICE_ACCOUNT_NAME --display-name=NGLState-$ENVIRONMENT
gcloud projects add-iam-policy-binding $PROJECT_NAME --member serviceAccount:$NGLSTATE_SERVICE_ACCOUNT_NAME@$PROJECT_NAME.iam.gserviceaccount.com --role roles/datastore.user
gsutil iam ch serviceAccount:$NGLSTATE_SERVICE_ACCOUNT_NAME@$PROJECT_NAME.iam.gserviceaccount.com:legacyBucketWriter,legacyObjectOwner,legacyObjectReader gs://$NGLSTATE_BUCKET_NAME


gcloud iam service-accounts create $CLOUD_DNS_SERVICE_ACCOUNT_NAME --display-name=cloud-dns-$ENVIRONMENT
gcloud projects add-iam-policy-binding $PROJECT_NAME --member serviceAccount:$CLOUD_DNS_SERVICE_ACCOUNT_NAME@$PROJECT_NAME.iam.gserviceaccount.com --role roles/dns.admin

gcloud iam service-accounts keys create ${KEY_FOLDER}/${CLOUD_SQL_SERVICE_ACCOUNT_NAME}.json --iam-account $CLOUD_SQL_SERVICE_ACCOUNT_NAME@$PROJECT_NAME.iam.gserviceaccount.com
gcloud iam service-accounts keys create ${KEY_FOLDER}/${NGLSTATE_SERVICE_ACCOUNT_NAME}.json --iam-account $NGLSTATE_SERVICE_ACCOUNT_NAME@$PROJECT_NAME.iam.gserviceaccount.com
gcloud iam service-accounts keys create ${KEY_FOLDER}/${AUTH_SERVICE_ACCOUNT_NAME}.json --iam-account $AUTH_SERVICE_ACCOUNT_NAME@$PROJECT_NAME.iam.gserviceaccount.com
gcloud iam service-accounts keys create ${KEY_FOLDER}/${CLOUD_DNS_SERVICE_ACCOUNT_NAME}.json --iam-account $CLOUD_DNS_SERVICE_ACCOUNT_NAME@$PROJECT_NAME.iam.gserviceaccount.com
