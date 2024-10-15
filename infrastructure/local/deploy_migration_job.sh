source env_config.sh
source $ENV_REPO_PATH/$1.sh

# Get replica counts for each service that communicates with the database
ANNOTATION_COUNT=${ANNOTATIONENGINE_MAX_REPLICAS:-0}
MATERIALIZATION_COUNT=${MAT_MAX_REPLICAS:-0}
CELERY_WORKER_COUNT=${CELERY_PRODUCER_MIN_REPLICAS:-0}


if (( $ANNOTATION_COUNT > 0 || $MATERIALIZATION_COUNT > 0 || $CELERY_WORKER_COUNT > 0 ));
then
  echo "Running database migration for materialize service"
  kubectl apply -f ${YAML_FOLDER}/materialize_migration.yml
  kubectl wait --for=condition=complete job/materialize-db-migration --timeout=600s
  if [ $? -ne 0 ]; then
    # echo "Migration job failed. Exiting deployment."
    exit 1
  fi
fi