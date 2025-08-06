source env_config.sh
source ./infrastructure/local/defaults.sh
source $ENV_REPO_PATH/$1.sh
./infrastructure/local/switch_context.sh $1

if [ -z "$MATERIALIZATION_UPLOAD_BUCKET_PATH" ]; then
  echo "MATERIALIZATION_UPLOAD_BUCKET_PATH is not set, exiting setup script"
  exit 1
else
  echo "MATERIALIZATION_UPLOAD_BUCKET_PATH is set to $MATERIALIZATION_UPLOAD_BUCKET_PATH"
  
  # Check if bucket exists
  if ! gsutil ls "gs://$MATERIALIZATION_UPLOAD_BUCKET_PATH" >/dev/null 2>&1; then
    echo "Bucket does not exist. Creating..."
    gsutil mb "gs://$MATERIALIZATION_UPLOAD_BUCKET_PATH" || {
      echo "ERROR: Failed to create bucket. Check if you have sufficient permissions."
      exit 1
    }
  else
    echo "$MATERIALIZATION_UPLOAD_BUCKET_PATH already exists"
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
gcloud storage buckets add-iam-policy-binding "gs://$MATERIALIZATION_UPLOAD_BUCKET_PATH" \
  --member="serviceAccount:$SQL_SERVICE_ACCOUNT" \
  --role="roles/storage.objectAdmin" || {
  echo "ERROR: Failed to modify bucket IAM policy."
  echo "You need 'storage.buckets.getIamPolicy' and 'storage.buckets.setIamPolicy' permissions."
  echo "Please request Storage Admin or Storage IAM Admin role from your GCP administrator."
  exit 1
}


if [ -n "$MATERIALIZATION_UPLOAD_BUCKET_PATH" ]; then
  echo "Granting $PYCG_SERVICE_ACCOUNT_NAME roles/storage.objectAdmin on gs://$MATERIALIZATION_UPLOAD_BUCKET_PATH"
  gcloud storage buckets add-iam-policy-binding "gs://$MATERIALIZATION_UPLOAD_BUCKET_PATH" \
    --member="serviceAccount:$PYCG_SERVICE_ACCOUNT_NAME@$PROJECT_NAME.iam.gserviceaccount.com" \
    --role="roles/storage.objectAdmin" || echo "WARNING: Failed to set IAM policy for $PYCG_SERVICE_ACCOUNT_NAME on gs://$MATERIALIZATION_UPLOAD_BUCKET_PATH"
else
  echo "WARNING: MATERIALIZATION_UPLOAD_BUCKET_PATH is not set. Skipping IAM policy for $PYCG_SERVICE_ACCOUNT_NAME."
fi
echo "Successfully granted storage.objectAdmin permission to $SQL_SERVICE_ACCOUNT on bucket $MATERIALIZATION_UPLOAD_BUCKET_PATH"