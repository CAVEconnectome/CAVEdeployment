
variable "environment" {
  description = "environment name to identify resources"
}

variable "project_id" {
  description = "google project id"
}

variable "region" {
  description = "region"
}

variable "terraform_bucket_name" {
  description = "Name of the terraform bucket"
}

variable "sql_instance_name" {
  description = "Name of the SQL instance"
}

variable "postgres_user_password" {
  description = "Password for the database writer"
}

variable "owner" {
  type = string
  description = "added as label to resources, convenient to filter costs based on labels"
  default = "na"
}

variable "postgres_write_user" {
  description = "Username for the database writer"
  default = "postgres"
}

variable "sql_instance_cpu" {
  description = "Number of CPUs for the SQL instance"
  default = 4
}

variable "sql_instance_memory_gb" {
  description = "Amount of memory for the SQL instance in gb"
  default = 16 # 10240 Mb in GB
}

variable "sql_temp_file_limit_gb" {
  description = "Temporary file size limit in gigabytes"
  type        = number
  default     = 100  # 104857600 Kb in GB
}

variable "sql_work_mem_mb" {
  description = "Amount of memory to be used by internal sort operations and hash tables in megabytes"
  type        = number
  default     = 64  # 64000 Kb in MB
}

variable "sql_maintenance_work_mem_gb" {
  description = "Maximum amount of memory to be used for maintenance operations in gigabytes"
  type        = number
  default     = 2  # 2097152 Kb in GB
}

variable "bigtable_instance_name" {
  description = "Name of the bigtable instance to be used by pychunkedgraph and l2cache"
  type        = string
  default     = "pychunkedgraph"
}

variable "bigtable_google_project" {
    description = <<EOF
        "name of the google project your bigtable sits in.
        Use only if it sits in a different project. Note: you will need to create
        a service account with the proper permissions"
    EOF
    type    = string
    default = ""
}

variable "pcg_redis_memory_size_gb" {
  type        = number
  default     = 1
  description = "redis instance size"
}

variable "pcg_redis_name" {
  description = "PCG Redis name (will default to owner-environment-pcg-redis)"
  type        = string
  default     = ""
}

variable "vpc_name" {
  description = "PCG Redis name (will default to owner-environment-pcg-redis)"
  type        = string
  default     = ""
}
