#!/bin/bash
source env_config.sh
source $ENV_REPO_PATH/$1.sh

# # Encode a file's contents to base64
encode_file() {
    cat "$1" | base64 | tr -d '\n'
}

# Paths to your secret files
CLOUDSQL_SECRET_PATH="${KEY_FOLDER}/${CLOUD_SQL_SERVICE_ACCOUNT_NAME}.json"
ANNOTATION_SECRET_PATH="${KEY_FOLDER}/${AE_SERVICE_ACCOUNT_NAME}.json"
CAVE_SECRET_PATH="${ADD_STORAGE_SECRET_FOLDER}/${CAVE_SECRET_FILENAME}"

# gcloud secrets create cloudsql-secret-$ENVIRONMENT --replication-policy="automatic" --data-file=${KEY_FOLDER}/${CLOUD_SQL_SERVICE_ACCOUNT_NAME}.json
# gcloud secrets create annotation-secret-$ENVIRONMENT --replication-policy="automatic" --data-file=${KEY_FOLDER}/${AE_SERVICE_ACCOUNT_NAME}.json
# gcloud secrets create cave-secret-$ENVIRONMENT --replication-policy="automatic" --data-file=${ADD_STORAGE_SECRET_FOLDER}/${CAVE_SECRET_FILENAME}

# Create the secrets file
cat << EOF > environments/${ENVIRONMENT}/secrets.yaml.dec
cloudsql:
  googleSecret: $(encode_file "$CLOUDSQL_SECRET_PATH")
  password: ${POSTGRES_WRITE_USER_PASSWORD}
materialize:
  secretFiles:
    - name: google-secret.json
      value: $(encode_file "$ANNOTATION_SECRET_PATH")
    - name: cave-secret.json
      value: $(encode_file "$CAVE_SECRET_PATH")
EOF
helm secrets encrypt environments/${ENVIRONMENT}/secrets.yaml.dec > environments/${ENVIRONMENT}/secrets.yaml