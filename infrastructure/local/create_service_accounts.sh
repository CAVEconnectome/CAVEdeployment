source env_config.sh
source ./infrastructure/local/defaults.sh
source $ENV_REPO_PATH/$1.sh
source ./infrastructure/local/convert_variables.sh

./infrastructure/local/switch_context.sh $1

mkdir -p ${KEY_FOLDER}
gcloud iam service-accounts create $PYCG_SERVICE_ACCOUNT_NAME --display-name=PyChunkedGraph-$ENVIRONMENT
gsutil iam ch serviceAccount:$PYCG_SERVICE_ACCOUNT_NAME@$PROJECT_NAME.iam.gserviceaccount.com:legacyBucketWriter,legacyObjectOwner,legacyObjectReader gs://$PCG_BUCKET_NAME
if [ -n "$MATERIALIZATION_DUMP_BUCKET_NAME" ]
then
    gsutil iam ch serviceAccount:$PYCG_SERVICE_ACCOUNT_NAME@$PROJECT_NAME.iam.gserviceaccount.com:legacyBucketWriter,legacyObjectOwner,legacyObjectReader gs://$MATERIALIZATION_DUMP_BUCKET_NAME
fi
gcloud projects add-iam-policy-binding $DATA_PROJECT_NAME --member serviceAccount:$PYCG_SERVICE_ACCOUNT_NAME@$PROJECT_NAME.iam.gserviceaccount.com --role roles/bigtable.user
gcloud projects add-iam-policy-binding $PROJECT_NAME --member serviceAccount:$PYCG_SERVICE_ACCOUNT_NAME@$PROJECT_NAME.iam.gserviceaccount.com --role roles/datastore.user
gcloud projects add-iam-policy-binding $PROJECT_NAME --member serviceAccount:$PYCG_SERVICE_ACCOUNT_NAME@$PROJECT_NAME.iam.gserviceaccount.com --role roles/pubsub.editor
gcloud projects add-iam-policy-binding $PROJECT_NAME --member serviceAccount:$PYCG_SERVICE_ACCOUNT_NAME@$PROJECT_NAME.iam.gserviceaccount.com --role roles/storage.objectViewer
gcloud projects add-iam-policy-binding $PROJECT_NAME --member serviceAccount:$PYCG_SERVICE_ACCOUNT_NAME@$PROJECT_NAME.iam.gserviceaccount.com --role roles/cloudsql.admin
gcloud projects add-iam-policy-binding $PROJECT_NAME --member serviceAccount:$PYCG_SERVICE_ACCOUNT_NAME@$PROJECT_NAME.iam.gserviceaccount.com --role roles/storage.objectAdmin


gcloud iam service-accounts create $SKELETON_SERVICE_ACCOUNT_NAME --display-name=SkeletonService-$ENVIRONMENT
gsutil iam ch serviceAccount:$SKELETON_SERVICE_ACCOUNT_NAME@$PROJECT_NAME.iam.gserviceaccount.com:legacyBucketWriter,legacyObjectOwner,legacyObjectReader gs://$(echo $SKELETON_CACHE_BUCKET | cut -d'/' -f1)
gcloud projects add-iam-policy-binding $PROJECT_NAME --member serviceAccount:$SKELETON_SERVICE_ACCOUNT_NAME@$PROJECT_NAME.iam.gserviceaccount.com --role roles/pubsub.editor
gcloud projects add-iam-policy-binding $PROJECT_NAME --member serviceAccount:$SKELETON_SERVICE_ACCOUNT_NAME@$PROJECT_NAME.iam.gserviceaccount.com --role roles/monitoring.viewer
gcloud projects add-iam-policy-binding $PROJECT_NAME --member serviceAccount:$SKELETON_SERVICE_ACCOUNT_NAME@$PROJECT_NAME.iam.gserviceaccount.com --role roles/monitoring.metricWriter

gcloud iam service-accounts create $AE_SERVICE_ACCOUNT_NAME --display-name=AnnotationEngine-$ENVIRONMENT
gcloud projects add-iam-policy-binding $PROJECT_NAME --member serviceAccount:$AE_SERVICE_ACCOUNT_NAME@$PROJECT_NAME.iam.gserviceaccount.com --role roles/bigtable.user


gcloud iam service-accounts create $PMANAGEMENT_SERVICE_ACCOUNT_NAME --display-name=PMANAGEMENT-$ENVIRONMENT
gcloud projects add-iam-policy-binding $PROJECT_NAME --member serviceAccount:$PMANAGEMENT_SERVICE_ACCOUNT_NAME@$PROJECT_NAME.iam.gserviceaccount.com --role roles/datastore.user


gcloud iam service-accounts create $CLOUD_SQL_SERVICE_ACCOUNT_NAME --display-name=CloudSQL-$ENVIRONMENT
gcloud projects add-iam-policy-binding $PROJECT_NAME --member serviceAccount:$CLOUD_SQL_SERVICE_ACCOUNT_NAME@$PROJECT_NAME.iam.gserviceaccount.com --role roles/cloudsql.client
gsutil iam ch serviceAccount:$PYCG_SERVICE_ACCOUNT_NAME@$PROJECT_NAME.iam.gserviceaccount.com:legacyBucketWriter,legacyObjectOwner,legacyObjectReader gs://$MATERIALIZATION_UPLOAD_BUCKET_NAME



# gcloud iam service-accounts create $AUTH_SERVICE_ACCOUNT_NAME --display-name=Auth-$ENVIRONMENT
# gcloud projects add-iam-policy-binding $PROJECT_NAME --member serviceAccount:$AUTH_SERVICE_ACCOUNT_NAME@$PROJECT_NAME.iam.gserviceaccount.com --role roles/redis.editor

gcloud iam service-accounts create $CLOUD_DNS_SERVICE_ACCOUNT_NAME --display-name=cloud-dns-$ENVIRONMENT
gcloud projects add-iam-policy-binding $PROJECT_NAME --member serviceAccount:$CLOUD_DNS_SERVICE_ACCOUNT_NAME@$PROJECT_NAME.iam.gserviceaccount.com --role roles/dns.admin

gcloud iam service-accounts keys create ${KEY_FOLDER}/${PYCG_SERVICE_ACCOUNT_NAME}.json --iam-account $PYCG_SERVICE_ACCOUNT_NAME@$PROJECT_NAME.iam.gserviceaccount.com
gcloud iam service-accounts keys create ${KEY_FOLDER}/${SKELETON_SERVICE_ACCOUNT_NAME}.json --iam-account $SKELETON_SERVICE_ACCOUNT_NAME@$PROJECT_NAME.iam.gserviceaccount.com
gcloud iam service-accounts keys create ${KEY_FOLDER}/${AE_SERVICE_ACCOUNT_NAME}.json --iam-account $AE_SERVICE_ACCOUNT_NAME@$PROJECT_NAME.iam.gserviceaccount.com
# gcloud iam service-accounts keys create ${KEY_FOLDER}/${NGLSTATE_SERVICE_ACCOUNT_NAME}.json --iam-account $NGLSTATE_SERVICE_ACCOUNT_NAME@$PROJECT_NAME.iam.gserviceaccount.com
gcloud iam service-accounts keys create ${KEY_FOLDER}/${CLOUD_SQL_SERVICE_ACCOUNT_NAME}.json --iam-account $CLOUD_SQL_SERVICE_ACCOUNT_NAME@$PROJECT_NAME.iam.gserviceaccount.com
gcloud iam service-accounts keys create ${KEY_FOLDER}/${CLOUD_DNS_SERVICE_ACCOUNT_NAME}.json --iam-account $CLOUD_DNS_SERVICE_ACCOUNT_NAME@$PROJECT_NAME.iam.gserviceaccount.com
gcloud iam service-accounts keys create ${KEY_FOLDER}/${PMANAGEMENT_SERVICE_ACCOUNT_NAME}.json --iam-account $PMANAGEMENT_SERVICE_ACCOUNT_NAME@$PROJECT_NAME.iam.gserviceaccount.com

./infrastructure/local/setup_materialization_bucket.sh $1
