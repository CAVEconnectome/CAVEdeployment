source env_config.sh
source $ENV_REPO_PATH/$1.sh

./infrastructure/global/switch_context.sh $1

rm transaction.yaml
for ((i=0;i<${#DNS_HOSTNAMES[@]};++i));
do
    gcloud dns record-sets transaction start -z=${DNS_ZONES[i]} --project=${DNS_PROJECT_NAME}
    gcloud dns record-sets transaction remove -z=${DNS_ZONES[i]} --project=${DNS_PROJECT_NAME} \
       --name="${DNS_HOSTNAMES[i]}" \
       --type=A \
       --ttl=300 "${EXTERNAL_IP_ADDRESS_WO_QUOTES}"
    gcloud dns record-sets transaction execute -z=${DNS_ZONES[i]} --project=${DNS_PROJECT_NAME}
    rm transaction.yaml
done

for ((i=0;i<${#DNS_HOSTNAMES[@]};++i));
do
    gcloud dns record-sets transaction start -z=${DNS_ZONES[i]} --project=${DNS_PROJECT_NAME}
    gcloud dns record-sets transaction add -z=${DNS_ZONES[i]} --project=${DNS_PROJECT_NAME} \
       --name="${DNS_HOSTNAMES[i]}" \
       --type=A \
       --ttl=300 "${EXTERNAL_IP_ADDRESS_WO_QUOTES}"
    gcloud dns record-sets transaction execute -z=${DNS_ZONES[i]} --project=${DNS_PROJECT_NAME}
    rm transaction.yaml
done
