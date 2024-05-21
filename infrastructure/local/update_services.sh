source env_config.sh
source $ENV_REPO_PATH/$1.sh

./infrastructure/local/switch_context.sh $1

#export REDIS_IP="$(gcloud redis instances describe $REDIS_NAME --region=$REGION | sed -n -e 's/^host: \(.*\)$/\1/p')"
./infrastructure/local/create_yaml_files_from_templates.sh $1

MAX_REPLICA_ARRAY=(
${PCGL2CACHE_MAX_REPLICAS}
${SKELETONCACHE_MAX_REPLICAS}
${ANNOTATIONENGINE_MAX_REPLICAS}
${PYCG_MAX_REPLICAS}
${MAT_MAX_REPLICAS}
${CELERY_BEAT_REPLICAS}
${PROXY_MAX_REPLICAS}
${MESHING_MAX_REPLICAS}
${MESHWORKER_MAX_REPLICAS}
${REMESHWORKER_MAX_REPLICAS}
${GUIDEBOOK_MAX_REPLICAS}
${DASH_MAX_REPLICAS}
${PPROGRESS_MAX_REPLICAS}
${PMANAGEMENT_MAX_REPLICAS}
${CAVECANERY_MAX_REPLICAS})

SERVICE_ARRAY=(
pcgl2cache
skeletoncache
annotation
pychunkedgraph
materialize
materialize_worker
proxy
meshing
mesh_worker
remesh_worker
guidebook
dash
pprogress
pmanagement
cavecanary)

for i in $(seq 0 1 $((${#MAX_REPLICA_ARRAY[@]}-1))); do
  echo $i

  if (( ${MAX_REPLICA_ARRAY[i]} > 0 ))
  then
    echo "enabling ${SERVICE_ARRAY[i]}"
    kubectl apply -f ${YAML_FOLDER}/${SERVICE_ARRAY[i]}.yml
  else
    echo "disabling ${SERVICE_ARRAY[i]}"
    kubectl delete -f ${YAML_FOLDER}/${SERVICE_ARRAY[i]}.yml
  fi
done

kubectl apply -f ${YAML_FOLDER}/auth-info.yml
kubectl apply -f ${YAML_FOLDER}/ingress.yml

# Logging
kubectl apply -f ${YAML_FOLDER}/fluentd-custom-configmap.yml
kubectl apply -f ${YAML_FOLDER}/fluentd-custom-daemonset.yml
