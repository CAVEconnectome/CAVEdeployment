export ENVIRONMENT={{ environment_name }}


# GOOGLE ACCOUNT DETAILS

export PROJECT_NAME={{ project_name }}
export REGION={{ depl_region }}
export ZONE={{ depl_zone }}
export DNS_ZONE={{ dns_zone }}
export DOMAIN_NAME={{ domain_name }}
export CLUSTER_NAME=daf-$ENVIRONMENT
export NETWORK_NAME=daf-$ENVIRONMENT-network
export SUBNETWORK_NAME=daf-$ENVIRONMENT-network-sub
export EXTERNAL_IP_ADDRESS_WO_QUOTES="$(gcloud compute addresses describe $CLUSTER_NAME --region=$REGION | grep address: | sed 's?address: ??')"
export EXTERNAL_IP_ADDRESS="'${EXTERNAL_IP_ADDRESS_WO_QUOTES}'"
export LETSENCRYPT_EMAIL={{ letsencrypt_email }}
export LETSENCRYPT_SERVER=https://acme-v02.api.letsencrypt.org/directory
export LETSENCRYPT_ISSUER_NAME=letsencrypt-staging

# DATA PROJECT DETAILS

export DOCKER_REPOSITORY={{ docker_repository }}


# KUBERNETES DEPLOYMENT DETAILS

export NGINX_INGRESS_CONTROLLER_NAME=contrasting-umbrellabird
export NGINX_INGRESS_SERVICE_NAME=nginx-ingress-service
export DNS_HOSTNAME=${ENVIRONMENT}.${DOMAIN_NAME}
export CRD_GITHUB_PATH=https://raw.githubusercontent.com/jetstack/cert-manager/release-0.8/deploy/manifests/00-crds.yaml
export DNS_HOSTNAMES=({{ dns_hostnames }})
export DNS_ZONES=({{ dns_zones }})

DNS_HOSTNAMES_DASHED=''
for dns_hostname in ${DNS_HOSTNAMES[@]};
do
    DNS_HOSTNAMES_DASHED=$DNS_HOSTNAMES_DASHED'
  - '"${dns_hostname}"
done
export DNS_HOSTNAMES_DASHED
export DNS_HOSTNAMES_DB_TABBED=$(echo "$DNS_HOSTNAMES_DASHED" | sed 's/  /    /g')
export DNS_HOSTNAMES_TR_TABBED=$(echo "$DNS_HOSTNAMES_DASHED" | sed 's/  /      /g')

DNS_INGRESS_PARA=''
for dns_hostname in ${DNS_HOSTNAMES[@]};
do
    DNS_INGRESS_PARA=$DNS_INGRESS_PARA'
  - host: '"${dns_hostname}"'
    http: *http_rules'
done
export DNS_INGRESS_PARA


# SQL INSTANCE

export SQL_INSTANCE_CPU=1
export SQL_INSTANCE_MEMORY=4
export SQL_AUTH_DB_NAME=authentication
export SQL_INFO_DB_NAME=infoservice
export SQL_DB_TYPE=postgresql
export POSTGRES_WRITE_USER=postgres
export POSTGRES_WRITE_USER_PASSWORD={{ postgres_password }}

# INSTANCE NAMES

export REDIS_NAME=daf-redis-$ENVIRONMENT
export REDIS_IP="$(gcloud redis instances describe $REDIS_NAME --region=$REGION | sed -n -e 's/^host: \(.*\)$/\1/p')"
export SQL_INSTANCE_NAME={{ sql_instance_name }}

# SERVICE ACCOUNTS

export NGLSTATE_SERVICE_ACCOUNT_NAME=daf-nglstate-$ENVIRONMENT
export CLOUD_SQL_SERVICE_ACCOUNT_NAME=daf-cloudsqlproxy-$ENVIRONMENT
export AUTH_SERVICE_ACCOUNT_NAME=daf-auth-$ENVIRONMENT
export CLOUD_DNS_SERVICE_ACCOUNT_NAME=daf-clouddns-$ENVIRONMENT

# SERVICE ACCOUNT SECRETS

export NGLSTATE_SERVICE_ACCOUNT_SECRET=${NGLSTATE_SERVICE_ACCOUNT_NAME}-cred
export INFOSERVICE_SERVICE_ACCOUNT_SECRET=daf-infoservice-secret-$ENVIRONMENT-cred
export CLOUD_SQL_SERVICE_ACCOUNT_SECRET=${CLOUD_SQL_SERVICE_ACCOUNT_NAME}-cred
export AUTH_SERVICE_ACCOUNT_SECRET=${AUTH_SERVICE_ACCOUNT_NAME}-cred
export CLOUD_DNS_SERVICE_ACCOUNT_SECRET=${CLOUD_DNS_SERVICE_ACCOUNT_NAME}-cred
export AUTH_OAUTH_SECRET=daf-oauth-${ENVIRONMENT}-cred
export GOOGLE_SECRET_FILENAME=google-secret.json
export OAUTH_SECRET_FILENAME=oauth-secret-${ENVIRONMENT}.json
export CAVE_SECRET_FILENAME=cave-secret.json

# PATHS

export ROOT_FOLDER=$PWD
export KEY_FOLDER=${ROOT_FOLDER}/gcloud_keys/$ENVIRONMENT
export YAML_FOLDER=${ROOT_FOLDER}/kubeyamls/${ENVIRONMENT}
export ADD_STORAGE_SECRET_FOLDER=${ROOT_FOLDER}/secrets/${ENVIRONMENT}/

# SERVICE VERSIONS

export AUTH_VERSION=2.24.0
export NGLSTATE_VERSION=0.6.0
export INFOSERVICE_VERSION=4.0.3
export EMANNOTATIONSCHEMAS_VERSION=5.12.0



# REPLICAS

export AUTH_REPLICAS=2
export NGL_STATE_REPLICAS=1
export EMANNOTATIONSCHEMAS_REPLICAS=1
export INFO_REPLICAS=1


# INFO

export INFOSERVICE_CONFIG_VERSION=5
export INFOSERVICE_CSRF_SECRET_KEY={{ infoservice_csrf_key }}
export INFOSERVICE_SECRET_KEY={{ infoservice_secret_key }}
export NEUROGLANCER_VIEWER_URL="https://neuromancer-seung-import.appspot.com/"


# AUTH
export AUTHSERVICE_CONFIG_VERSION=1.10
export AUTHSERVICE_SECRET_KEY={{ authservice_secret_key }}

export GLOBAL_SERVER={{ global_server }}
export AUTH_URI=${GLOBAL_SERVER}/auth
export AUTH_URL=${GLOBAL_SERVER}/auth
export INFO_URL=${GLOBAL_SERVER}/info
export STICKY_AUTH_URL=${GLOBAL_SERVER}/sticky_auth
export AUTH_DEFAULT_ADMINS="{{ default_admins }}"

# STATESERVER

export JSON_DB_TABLE_NAME={{ ngl_link_db_table_name }}

# AUTH-INFO
export NGINX_CONFIG_VERSION=2
