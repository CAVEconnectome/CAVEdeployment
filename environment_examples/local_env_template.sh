export ENVIRONMENT={{ environment_name }}

# GOOGLE ACCOUNT DETAILS

export PROJECT_NAME={{ project_name }}
export PCG_BUCKET_NAME={{ pcg_bucket_name }}
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

export NGINX_CONFIG_VERSION=2
export SUPPORTED_DATASTACKS='{{ supported_datastacks }}'

# DATA PROJECT DETAILS

export DATA_PROJECT_NAME={{ data_project_name }}
export DATA_REGION={{ data_project_region }}
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
export DNS_HOSTNAMES_DB_TABBED=$(echo "$DNS_HOSTNAMES_DASHED" | sed 's?  ?    ?g')
export DNS_HOSTNAMES_TR_TABBED=$(echo "$DNS_HOSTNAMES_DASHED" | sed 's?  ?      ?g')

DNS_INGRESS_PARA=''
for dns_hostname in ${DNS_HOSTNAMES[@]};
do
    DNS_INGRESS_PARA=$DNS_INGRESS_PARA'
  - host: '"${dns_hostname}"'
    http: *http_rules'
done
export DNS_INGRESS_PARA


# SQL INSTANCE

export SQL_INSTANCE_CPU=4
export SQL_INSTANCE_MEMORY=16
export SQL_ANNO_DB_NAME=annotation
export SQL_AUTH_DB_NAME=authentication
export SQL_MAT_DB_NAME=materialization
export SQL_INFO_DB_NAME=infoservice
export SQL_DB_TYPE=postgres
export POSTGRES_WRITE_USER=postgres
export POSTGRES_WRITE_USER_PASSWORD={{ postgres_password }}

## INSTANCE NAMES

export PCG_REDIS_NAME=pcg-cache
export PCG_REDIS_IP="$(gcloud redis instances describe $PCG_REDIS_NAME --region=$REGION | sed -n -e 's/^host: \(.*\)$/\1/p')"
# export REDIS_NAME=svenmd-daf-redis-$ENVIRONMENT
export SQL_INSTANCE_NAME={{ sql_instance_name }}
export BIGTABLE_INSTANCE_NAME={{ bigtable_instance_name }}

# SERVICE ACCOUNTS

export PYCG_SERVICE_ACCOUNT_NAME=daf-pychunkedgraph-$ENVIRONMENT
export AE_SERVICE_ACCOUNT_NAME=daf-annotationengine-$ENVIRONMENT
export NGLSTATE_SERVICE_ACCOUNT_NAME=daf-nglstate-$ENVIRONMENT
export CLOUD_SQL_SERVICE_ACCOUNT_NAME=daf-cloudsqlproxy-$ENVIRONMENT
export AUTH_SERVICE_ACCOUNT_NAME=daf-auth-$ENVIRONMENT
export CLOUD_DNS_SERVICE_ACCOUNT_NAME=daf-clouddns-$ENVIRONMENT
export PMANAGEMENT_SERVICE_ACCOUNT_NAME=daf-pmanagement-$ENVIRONMENT
export ADD_STORAGE_NAME=daf-storage-$ENVIRONMENT


# SERVICE ACCOUNT SECRETS

export PYCG_SERVICE_ACCOUNT_SECRET=${PYCG_SERVICE_ACCOUNT_NAME}-cred
export AE_SERVICE_ACCOUNT_SECRET=${AE_SERVICE_ACCOUNT_NAME}-cred
export NGLSTATE_SERVICE_ACCOUNT_SECRET=${NGLSTATE_SERVICE_ACCOUNT_NAME}-cred
export CLOUD_SQL_SERVICE_ACCOUNT_SECRET=${CLOUD_SQL_SERVICE_ACCOUNT_NAME}-cred
export AUTH_SERVICE_ACCOUNT_SECRET=${AUTH_SERVICE_ACCOUNT_NAME}-cred
export CLOUD_DNS_SERVICE_ACCOUNT_SECRET=${CLOUD_DNS_SERVICE_ACCOUNT_NAME}-cred
export PMANAGEMENT_SERVICE_ACCOUNT_SECRET=${PMANAGEMENT_SERVICE_ACCOUNT_NAME}-cred
export AUTH_OAUTH_SECRET=daf-oauth-${ENVIRONMENT}-cred
export GOOGLE_SECRET_FILENAME=google-secret.json
export CAVE_SECRET_FILENAME=cave-secret.json
export PMANAGEMENT_SECRET_FILENAME=pmanagement-secret.json
export OAUTH_SECRET_FILENAME=oauth-secret-${ENVIRONMENT}.json

# PATHS

export ROOT_FOLDER=$PWD
export KEY_FOLDER=${ROOT_FOLDER}/gcloud_keys/$ENVIRONMENT
export YAML_FOLDER=${ROOT_FOLDER}/kubeyamls/${ENVIRONMENT}
export ADD_STORAGE_SECRET_FOLDER=${ROOT_FOLDER}/secrets/${ENVIRONMENT}/

# SERVICE VERSIONS

export ANNOTATION_ENGINE_VERSION=3.6.6
export ANNOTATION_UI_VERSION=0.2.1
export MATERIALIZE_VERSION=3.0.7
export PYCG_VERSION=2.3.1
export PCGL2CACHE_VERSION=1.1.1
export GUIDEBOOK_VERSION=0.3.2
export DASH_VERSION=29
export PPROGRESS_VERSION=0.0.47
export PMANAGEMENT_VERSION=0.15.2
export PROXY_VERSION=RequestorPays12
export CAVECANARY_VERSION=0.1.2

# REPLICAS
### PCG 
export PYCG_MIN_REPLICAS=1
export PYCG_MAX_REPLICAS=3
export MESHING_MIN_REPLICAS=1
export MESHING_MAX_REPLICAS=3
export MESHWORKER_MIN_REPLICAS=1
export MESHWORKER_MAX_REPLICAS=3
export REMESHWORKER_MIN_REPLICAS=1
export REMESHWORKER_MAX_REPLICAS=3
### PCG aux
export GUIDEBOOK_MIN_REPLICAS=1
export GUIDEBOOK_MAX_REPLICAS=1
export GUIDEBOOK_WORKER_MIN_REPLICAS=1
export GUIDEBOOK_WORKER_MAX_REPLICAS=5
export PCGL2CACHE_MIN_REPLICAS=0
export PCGL2CACHE_MAX_REPLICAS=0
export PCGL2CACHE_WORKER_MIN_REPLICAS=0
export PCGL2CACHE_WORKER_MAX_REPLICAS=0

### Annotations
export ANNOTATIONENGINE_MIN_REPLICAS=0
export ANNOTATIONENGINE_MAX_REPLICAS=0
export MAT_MIN_REPLICAS=0
export MAT_MAX_REPLICAS=0
export CELERY_PRODUCER_MIN_REPLICAS=0
export CELERY_PRODUCER_MAX_REPLICAS=0
export CELERY_CONSUMER_MIN_REPLICAS=0
export CELERY_CONSUMER_MAX_REPLICAS=0
export CELERY_BEAT_REPLICAS=0
export DASH_MIN_REPLICAS=0
export DASH_MAX_REPLICAS=0
### OTHER 
export PPROGRESS_MIN_REPLICAS=0
export PPROGRESS_MAX_REPLICAS=0
export PMANAGEMENT_MIN_REPLICAS=0
export PMANAGEMENT_MAX_REPLICAS=0
export PROXY_MIN_REPLICAS=0
export PROXY_MAX_REPLICAS=0
#CAVECANARY
export CAVECANARY_MIN_REPLICAS=0
export CAVECANARY_MAX_REPLICAS=0

# MATERIALIZATION
export MATERIALIZE_CONFIG_VERSION=16
export MAT_HEALTH_ALIGNED_VOLUME_NAME={{ mat_health_aligned_volume_name }}
export MATERIALIZE_CRONJOB_SUSPENDED=false
export MAT_DATASTACKS="{{ mat_datastacks }}"
export MIN_DATABASES=1
export MAX_DATABASES=2
export MAT_BEAT_SCHEDULES=$(cat {{ mat_beat_schedule }})
export MERGE_MATERIALIZE_DATABASES=False
export LIMITS_QUERY_PER_MINUTE=200
export LIMITS_FAST_QUERY_PER_MINUTE=2000
export LIMITER_URI=redis://${PCG_REDIS_IP}/0
export MAT_LIMITER_CATEGORIES={\"query\":\"${LIMITS_QUERY_PER_MINUTE}/minute\"\,\"fast_query\":\"${LIMITS_FAST_QUERY_PER_MINUTE}/minute\"}


# ANNOTATION_ENGINE
export ANNOTATION_ENGINE_CONFIG_VERSION=1.4
export ANNOTATION_EXCLUDED_PERMISSION_GROUPS = "{{ ann_excluded_permission_groups }}"

# PYCHUNKEDGRAPH
export PCG_CONFIG_VERSION=6
export PYCG_MEM_GIB=4
export PYCG_MILLI_CPU=1000
export PCG_GRAPH_IDS="{{ pcg_graph_ids }}"
export PCG_CONFIG=""
export PYCHUNKEDGRAPH_EDITS_EXCHANGE="${ENVIRONMENT}_PCG_EDIT"
export PYCHUNKEDGRAPH_REMESH_QUEUE="${ENVIRONMENT}_PCG_HIGH_PRIORITY_REMESH"
export PYCHUNKEDGRAPH_LOW_PRIORITY_REMESH_QUEUE="${ENVIRONMENT}_PCG_LOW_PRIORITY_REMESH"


# PROXY
export PROXY_CONFIG_VERSION=1.12
export PROXY_MAP="{{ proxy_map }}"

# PCGL2CACHE
export L2CACHE_CONFIG_VERSION=1
export L2CACHE_CONFIG=$(cat {{ l2cache_config_filename }} | awk '{printf "    %s\n", $0}')
export L2CACHE_UPDATE_QUEUE="${ENVIRONMENT}_L2CACHE_WORKER"
export L2CACHE_EXCHANGE="${ENVIRONMENT}_L2CACHE"
export L2CACHE_TRIGGER_QUEUE="${ENVIRONMENT}_L2CACHE_HIGH_PRIORITY_TRIGGER"
export L2CACHE_TRIGGER_LOW_PRIORITY_QUEUE="${ENVIRONMENT}_L2CACHE_LOW_PRIORITY_TRIGGER"



# AUTH
export AUTHSERVICE_CONFIG_VERSION=1.6
export AUTHSERVICE_SECRET_KEY="{{ authservice_secret_key }}"
export GLOBAL_SERVER={{ global_server }}
export AUTH_URI=${GLOBAL_SERVER}/auth
export AUTH_URL=${GLOBAL_SERVER}/auth
export INFO_URL=${GLOBAL_SERVER}/info
export STICKY_AUTH_URL=${GLOBAL_SERVER}/sticky_auth

# GUIDEBOOK
export GUIDEBOOK_CSRF_KEY="{{ guidebook_csrf_key }}"
export GUIDEBOOK_DATASTACK="{{ guidebook_datastack }}"
export GUIDEBOOK_N_PARALLEL=1
export GUIDEBOOK_EXPECTED_RESOLUTION={{ guidebook_expected_resolution }}
export GUIDEBOOK_INVALIDATION_D=3
if ((${PCGL2CACHE_MIN_REPLICAS}>0))
then 
   export GUIDEBOOK_ENABLE_L2CACHE=true
else
   export GUIDEBOOK_ENABLE_L2CACHE=false
fi

# DASH
export DASH_SECRET_KEY="{{ dash_secret_key }}"
export DASH_CONFIG=$(cat {{ dash_config_filename }} | awk '{printf "    %s\n", $0}')
export DASH_CONFIG_VERSION=6

# DEFINE ADD SECRET IMPORT
export PYCG_SERVICE_ACCOUNT_ADDON="{{ pcg_service_account_addon }}"
export MAT_REDIS_PASSWORD=""
export MAT_REDIS_NAME={{ project_name }}-celery-redis
export MAT_REDIS_HOST="$(gcloud redis instances describe $MAT_REDIS_NAME --region=$REGION | sed -n -e 's/^host: \(.*\)$/\1/p')"
export MAT_REDIS_PORT=6379


# CELERY
export CELERY_WORKER_POOL="celery-pool"
# this will depend on the node type in your celery pool
# roughly you should have concurency=# of cpu in pool
# cpu should be (1000m*concurrency) - 500m
# memory should be 200Mi*concurrency
export CELERY_CONSUMER_CONCURRENCY=2
export CELERY_PRODUCER_CONCURRENCY=2
export CELERY_CPU="500m"
export CELERY_MEMORY="400Mi"
export CONSUMER_QUEUE_NAME="process"
export PRODUCER_QUEUE_NAME="workflow"
export CELERY_CONSUMER_WORKER_NAME="worker.${CONSUMER_QUEUE_NAME}"
export CELERY_PRODUCER_WORKER_NAME="worker.${PRODUCER_QUEUE_NAME}"

# CAVECANARY
export CAVECANARY_CONFIG_VERSION=1.8
export SLACK_API_TOKEN={{ slack_token }}
export SLACK_CHANNEL={{ slack_channel}}


#OTHER POOLS
export STANDARD_POOL="standard-pool"
export LIGHTWEIGHT_POOL="lightweight-pool"
export CORE_POOL="core-pool"
export MESH_POOL="mesh-pool"