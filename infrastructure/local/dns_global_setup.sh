source environments/local/$1.sh

gcloud dns managed-zones create "${DNS_ZONE}" --dns-name="${DOMAIN_NAME}" --description="zone for ${DOMAIN_NAME}"