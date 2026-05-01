# Set default values for local infrastructure configuration

# Materialization engine configuration
export MAT_QUERY_LIMIT_SIZE=500000
export MAT_LOG_LEVEL=WARNING
export MAT_SERVICE_MEM=850Mi

# Derive MATERIALIZATION_UPLOAD_BUCKET_NAME / MATERIALIZATION_UPLOAD_BUCKET_PATH
# from each other if only one is set.
#
# Both must be a plain bucket name (e.g. "my-bucket") — subdirectories are not
# supported; the app passes the value directly to the GCS client's bucket() method.
# NAME is used for IAM and gsutil operations; PATH is used by the app config.
if [ -n "${MATERIALIZATION_UPLOAD_BUCKET_PATH}" ] && [ -z "${MATERIALIZATION_UPLOAD_BUCKET_NAME}" ]; then
    # Strip any leading gs:// and take the first path component (the bucket name)
    export MATERIALIZATION_UPLOAD_BUCKET_NAME=$(echo "${MATERIALIZATION_UPLOAD_BUCKET_PATH}" | sed 's|^gs://||' | cut -d'/' -f1)
elif [ -n "${MATERIALIZATION_UPLOAD_BUCKET_NAME}" ] && [ -z "${MATERIALIZATION_UPLOAD_BUCKET_PATH}" ]; then
    # No sub-path specified — use the bucket root
    export MATERIALIZATION_UPLOAD_BUCKET_PATH="${MATERIALIZATION_UPLOAD_BUCKET_NAME}"
fi
