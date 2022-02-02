source environments/local/$1.sh

./infrastructure/local/switch_context.sh $1

mkdir -p ${YAML_FOLDER}
envsubst < kubetemplates/$2.yml > ${YAML_FOLDER}/$2.yml
kubectl apply -f ${YAML_FOLDER}/$2.yml
