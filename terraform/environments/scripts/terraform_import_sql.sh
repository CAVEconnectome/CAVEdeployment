#!/bin/bash

# Extract values from Terraform outputs
project_id=$(terraform output -raw project_id)
sql_instance_name=$(terraform output -raw sql_instance_name)
postgres_write_user=$(terraform output -raw postgres_write_user)

# Construct the resource ID
resource_id="${project_id}/${sql_instance_name}/${postgres_write_user}"

# import the postgres database
terraform import "module.cave.google_sql_database_instance.postgres" "$sql_instance_name"

# Run the Terraform import command
terraform import "module.cave.google_sql_user.writer" "$resource_id"
