#!/bin/bash

# Set GCP User Account
export TF_VAR_gcp_user_account=$(gcloud config get-value account)

# Run Terraform Apply
terraform apply