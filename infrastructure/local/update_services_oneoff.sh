source env_config.sh
source $ENV_REPO_PATH/$1.sh
source ./infrastructure/local/convert_variables.sh

./infrastructure/local/switch_context.sh $1

if [[ $2 = "skeletoncache" || $2 = "skeletoncache_integrationtests_only" ]]; then
    # We have to explicitly delete the integration test job before running a new one.
    # Kubernetes won't do this for us.
    if kubectl get job skeletoncache-integration-tester &> /dev/null; then
        echo "Deleting integration test job: skeletoncache-integration-tester"
        kubectl delete job skeletoncache-integration-tester
    fi
fi

./infrastructure/local/deploy_migration_job.sh $1

mkdir -p ${YAML_FOLDER}
envsubst < kubetemplates/$2.yml > ${YAML_FOLDER}/$2.yml
kubectl apply -f ${YAML_FOLDER}/$2.yml