source env_config.sh
source $ENV_REPO_PATH/$1.sh

./infrastructure/local/switch_context.sh $1


if [ -z "$MATERIALIZATION_UPLOAD_BUCKET_NAME" ]; then
    echo "MATERIALIZATION_UPLOAD_BUCKET_NAME is not set, skipping exiting setup script"
    exit 1
else
    echo "MATERIALIZATION_UPLOAD_BUCKET_NAME is set to $MATERIALIZATION_UPLOAD_BUCKET_NAME"
    if ! gsutil ls "gs://$MATERIALIZATION_UPLOAD_BUCKET_NAME" >/dev/null 2>&1; then
        echo "Bucket does not exist. Creating..."
        gsutil mb "gs://$MATERIALIZATION_UPLOAD_BUCKET_NAME"
    else
        echo "$MATERIALIZATION_UPLOAD_BUCKET_NAME already exists"
    fi
fi

SQL_SERVICE_ACCOUNT=$(gcloud sql instances describe "$SQL_INSTANCE_NAME" \
    --format="value(serviceAccountEmailAddress)")

echo "Granting $SQL_SERVICE_ACCOUNT access to the bucket"

gsutil iam ch \
    "serviceAccount:$SQL_SERVICE_ACCOUNT:roles/storage.objectViewer" \
    "gs://$MATERIALIZATION_UPLOAD_BUCKET_NAME"



