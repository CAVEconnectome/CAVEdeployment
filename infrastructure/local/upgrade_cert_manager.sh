#!/bin/bash

source env_config.sh
source ./infrastructure/local/defaults.sh
source $ENV_REPO_PATH/$1.sh
source ./infrastructure/local/convert_variables.sh
./infrastructure/local/switch_context.sh $1

kubectl apply -f $YAML_FOLDER/service-accounts.yml

helm upgrade \
 -f $YAML_FOLDER/cert-manager-values.yml \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v1.8.0 \
  --set installCRDs=true

