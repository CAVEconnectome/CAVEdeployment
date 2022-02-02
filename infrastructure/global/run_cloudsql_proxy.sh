source environments/global/$1.sh

export INSTANCE_CONNECTION_NAME=$PROJECT_NAME:$REGION:$SQL_INSTANCE_NAME

docker pull gcr.io/cloudsql-docker/gce-proxy:1.16
docker rm --force gce-proxy
docker rm --force adminer
docker run -d \
-v $HOME/.config/gcloud/:/config \
  -p 127.0.0.1:3306:3306 \
  --name gce-proxy \
  gcr.io/cloudsql-docker/gce-proxy:1.16 /cloud_sql_proxy \
  -instances=$INSTANCE_CONNECTION_NAME=tcp:0.0.0.0:3306 -credential_file=/config/application_default_credentials.json
docker run --link gce-proxy:db -p 8080:8080 --name adminer adminer