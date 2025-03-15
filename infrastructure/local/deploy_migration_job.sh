source env_config.sh
source $ENV_REPO_PATH/$1.sh
source ./infrastructure/local/convert_variables.sh

# Get replica counts for each service that communicates with the database
ANNOTATION_COUNT=${ANNOTATIONENGINE_MAX_REPLICAS:-0}
MATERIALIZATION_COUNT=${MAT_MAX_REPLICAS:-0}
CELERY_WORKER_COUNT=${CELERY_PRODUCER_MIN_REPLICAS:-0}

if (( $ANNOTATION_COUNT > 0 || $MATERIALIZATION_COUNT > 0 || $CELERY_WORKER_COUNT > 0 )); then
    echo "Running database migration for materialize service"
    
    # Check if the job exists before attempting to delete it
    if kubectl get job materialize-db-migration &> /dev/null; then
        echo "Deleting existing migration job"
        kubectl delete job materialize-db-migration
    else
        echo "No existing migration job found"
    fi

    echo "Creating migration template"
    envsubst < kubetemplates/materialize_migrations.yml > ${YAML_FOLDER}/materialize_migrations.yml
    
    echo "Applying migration job"
    kubectl apply -f ${YAML_FOLDER}/materialize_migrations.yml

    echo "Waiting for migration job to complete"

    job_name="materialize-db-migration"
    check_interval=5  # Check every 5 seconds
    timeout=600  # Total timeout in seconds (10 minutes)
    elapsed=0

    while [ $elapsed -lt $timeout ]; do
        # Check if the job exists
        if ! kubectl get job $job_name &> /dev/null; then
            echo "Migration job not found. It may have been deleted. Exiting deployment."
            exit 1
        fi

        # Get the job status
        job_status=$(kubectl get job $job_name -o jsonpath='{.status.conditions[*].type}')
        
        if [[ $job_status == *"Complete"* ]]; then
            echo "Migration job completed. Checking exit code..."
            pod_name=$(kubectl get pods --selector=job-name=$job_name --output=jsonpath='{.items[*].metadata.name}')
            exit_code=$(kubectl get pod $pod_name -o jsonpath='{.status.containerStatuses[?(@.name=="cloudsql-proxy")].state.terminated.exitCode}')
            
            case $exit_code in
                0)
                    echo "Migration completed successfully."
                    ;;
                1)
                    echo "Error: Migration failed."
                    kubectl logs job/$job_name
                    exit 1
                    ;;
                2)
                    echo "Error: Cloud SQL Proxy did not become ready in time."
                    kubectl logs job/$job_name
                    exit 2
                    ;;
                3)
                    echo "No auto-migrate command found. No migration was necessary."
                    ;;
                *)
                    echo "Unknown exit code: $exit_code"
                    kubectl logs job/$job_name
                    exit $exit_code
                    ;;
            esac
            break
        elif [[ $job_status == *"Failed"* ]]; then
            echo "Migration job failed. Checking logs:"
            kubectl logs job/$job_name
            exit 1
        fi

        echo "Job still running. Time elapsed: $elapsed seconds. Timeout: $timeout seconds."
        sleep $check_interval
        elapsed=$((elapsed + check_interval))
    done

    if [ $elapsed -ge $timeout ]; then
        echo "Migration job timed out after $timeout seconds. Exiting deployment."
        kubectl logs job/$job_name
        exit 4  # Distinct exit code for timeout
    fi

    echo "Cleaning up the migration job"
    kubectl delete job $job_name
    echo "Migration process completed. Proceeding with deployment."
else 
    echo "No services require database migration. Proceeding with deployment."
fi
