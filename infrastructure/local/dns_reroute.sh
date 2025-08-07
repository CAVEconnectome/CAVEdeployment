source env_config.sh
source ./infrastructure/local/defaults.sh
source $ENV_REPO_PATH/$1.sh
source ./infrastructure/local/convert_variables.sh

rm transaction.yaml

gcloud dns record-sets transaction start -z=${DNS_ZONE}
gcloud dns record-sets transaction remove -z=${DNS_ZONE} \
   --name="${2}" \
   --type=A"
gcloud dns record-sets transaction add -z=${DNS_ZONE} \
   --name="${2}" \
   --type=A \
   --ttl=300 "${EXTERNAL_IP_ADDRESS_WO_QUOTES}"
gcloud dns record-sets transaction execute -z=${DNS_ZONE}
rm transaction.yaml
