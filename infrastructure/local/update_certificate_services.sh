source environments/local/$1.sh

./infrastructure/local/switch_context.sh $1
./infrastructure/local/create_yaml_files_from_templates.sh $1

# DNS CERTIFICATES
kubectl apply -f ${YAML_FOLDER}/cert-issuer.yml

sleep 100

kubectl apply -f ${YAML_FOLDER}/certificate.yml

sleep 300