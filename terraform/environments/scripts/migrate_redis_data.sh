#!/bin/bash

# Configuration for Memorystore instances and GCS
SOURCE_REDIS_INSTANCE_ID="source-instance-id"
TARGET_REDIS_INSTANCE_ID="target-instance-id"
GCS_BUCKET_NAME="your-gcs-bucket-name"
REGION="your-region" # Region of the Memorystore instances

# File name in GCS
EXPORT_FILE="memorystore_export.rdb"

echo "Starting Redis data export from the source Memorystore instance to GCS..."

# Export data from the source Memorystore instance to GCS
gcloud redis instances export $SOURCE_REDIS_INSTANCE_ID gs://$GCS_BUCKET_NAME/$EXPORT_FILE --region=$REGION
if [ $? -ne 0 ]; then
    echo "Failed to export data from source Memorystore instance"
    exit 1
fi

echo "Data exported successfully to GCS."

echo "Starting Redis data import from GCS to the target Memorystore instance..."

# Import data from GCS to the target Memorystore instance
gcloud redis instances import $TARGET_REDIS_INSTANCE_ID gs://$GCS_BUCKET_NAME/$EXPORT_FILE --region=$REGION
if [ $? -ne 0 ]; then
    echo "Failed to import data to the target Memorystore instance"
    exit 1
fi

echo "Data imported successfully to the target Memorystore instance."

echo "Redis data migration via GCS completed successfully."
