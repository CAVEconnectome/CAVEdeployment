#!/bin/bash

source env_config.sh
source $ENV_REPO_PATH/$1.sh

helm upgrade \
 -f $YAML_FOLDER/cert-manager-values.yml \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v1.8.0 \
  --set installCRDs=true

