source env_config.sh
source $ENV_REPO_PATH/$1.sh


kubectl apply -f $YAML_FOLDER/service-accounts.yml

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo add stable https://charts.helm.sh/stable
helm repo update
helm install ${NGINX_INGRESS_CONTROLLER_NAME} ingress-nginx/ingress-nginx --set rbac.create=true --namespace kube-system --version $NGINX_INGRESS_CHART_VERSION

gcloud compute addresses describe ${CLUSTER_NAME} --region $REGION | grep address: | sed "s/address: //"

# kubectl apply -f $CRD_GITHUB_PATH
#kubectl label namespace default certmanager.k8s.io/disable-validation="true"

helm repo add jetstack https://charts.jetstack.io
#helm install cert-manager-release jetstack/cert-manager -f $YAML_FOLDER/cert-manager-values.yml
kubectl create namespace cert-manager
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version $CERT_MANAGER_CHART_VERSION \
  -f $YAML_FOLDER/cert-manager-values.yml \
  --set installCRDs=true
./infrastructure/global/configure_ingress.sh $1
