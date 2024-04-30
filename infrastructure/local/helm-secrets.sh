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
PYCHUNKEDGRAPH_SECRET_PATH="${KEY_FOLDER}/daf-pychunkedgraph-$ENVIRONMENT.json"

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
pychunkedgraph:
  secretFiles:
    - name: google-secret.json
      value: $(encode_file $PYCHUNKEDGRAPH_SECRET_PATH)
    - name: cave-secret.json
      value: $(encode_file "$CAVE_SECRET_PATH")
$(for file in ${PCG_CREDENTIAL_FILES[@]}; do echo "    - name: $file"; echo "      value: $(encode_file ${ADD_STORAGE_SECRET_FOLDER}/$file)"; done)
annotation:
  secretFiles:
    - name: google-secret.json
      value: $(encode_file "$ANNOTATION_SECRET_PATH")
    - name: cave-secret.json
      value: $(encode_file "$CAVE_SECRET_PATH")
slack:
    apiToken: $SLACK_API_TOKEN
EOF
helm secrets encrypt environments/${ENVIRONMENT}/secrets.yaml.dec > environments/${ENVIRONMENT}/secrets.yaml