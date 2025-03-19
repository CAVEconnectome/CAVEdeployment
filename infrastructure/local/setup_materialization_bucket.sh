source env_config.sh
source $ENV_REPO_PATH/$1.sh
./infrastructure/local/switch_context.sh $1

if [ -z "$MATERIALIZATION_UPLOAD_BUCKET_NAME" ]; then
  echo "MATERIALIZATION_UPLOAD_BUCKET_NAME is not set, exiting setup script"
  exit 1
else
  echo "MATERIALIZATION_UPLOAD_BUCKET_NAME is set to $MATERIALIZATION_UPLOAD_BUCKET_NAME"
  
  # Check if bucket exists
  if ! gsutil ls "gs://$MATERIALIZATION_UPLOAD_BUCKET_NAME" >/dev/null 2>&1; then
    echo "Bucket does not exist. Creating..."
    gsutil mb "gs://$MATERIALIZATION_UPLOAD_BUCKET_NAME" || {
      echo "ERROR: Failed to create bucket. Check if you have sufficient permissions."
      exit 1
    }
  else
    echo "$MATERIALIZATION_UPLOAD_BUCKET_NAME already exists"
  fi
fi

# Get SQL service account
SQL_SERVICE_ACCOUNT=$(gcloud sql instances describe "$SQL_INSTANCE_NAME" \
  --format="value(serviceAccountEmailAddress)") || {
  echo "ERROR: Failed to retrieve SQL service account. Check if SQL_INSTANCE_NAME is correct."
  exit 1
}

echo "Attempting to grant $SQL_SERVICE_ACCOUNT access to the bucket..."

# Use the newer gcloud storage command instead of gsutil iam ch
echo "Setting IAM policy binding for the bucket..."
gcloud storage buckets add-iam-policy-binding "gs://$MATERIALIZATION_UPLOAD_BUCKET_NAME" \
  --member="serviceAccount:$SQL_SERVICE_ACCOUNT" \
  --role="roles/storage.objectAdmin" || {
  echo "ERROR: Failed to modify bucket IAM policy."
  echo "You need 'storage.buckets.getIamPolicy' and 'storage.buckets.setIamPolicy' permissions."
  echo "Please request Storage Admin or Storage IAM Admin role from your GCP administrator."
  exit 1
}

echo "Successfully granted storage.objectAdmin permission to $SQL_SERVICE_ACCOUNT on bucket $MATERIALIZATION_UPLOAD_BUCKET_NAME"