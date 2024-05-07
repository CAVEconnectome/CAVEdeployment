
variable "environment" {
  description = "environment name to identify resources"
}

variable "project_id" {
  description = "google project id"
}

variable "region" {
  description = "region"
}

variable "zone" {
  description = "zone"
}

variable "gcp_user_account" {
  description = "The GCP user account for creating ClusterRoleBinding"
}

variable "letsencrypt_email" {
  description = "email to use for getting certificates"
  type        = string
}

variable "sql_instance_name" {
  description = "Name of the SQL instance"
}

variable "postgres_user_password" {
  description = "Password for the database writer"
}

variable "pcg_redis_name" {
  description = "Name of the SQL instance"
}

variable "dns_zone" {
  description = "The name of the DNS managed zone"
  type        = string
}

variable "domain_name" {
  description = "The DNS name associated with this managed zone"
  type        = string
}

variable "dns_entries" {
  description = "Map of DNS entries, where each key is a unique identifier, and each value contains zone and domain name details."
  type = map(object({
    zone        = string
    domain_name = string
  }))
}

variable "pcg_bucket_name" {
    description = "name of bucket where bigtable needs to read and write data"
    type        = string
}

variable "owner" {
  type = string
  description = "added as label to resources, convenient to filter costs based on labels"
  default = "na"
}

# define the machine types
variable "standard_machine_type" {
  type        = string
  default     = "t2d-standard-4"
  description = "VM instance type for standard pool"
}
variable "lightweight_machine_type" {
  type        = string
  default     = "e2-small"
  description = "VM instance type for lightweight pool"
}
variable "mesh_machine_type" {
  type        = string
  default     = "t2d-standard-4"
  description = "VM instance type for mesh pool"
}
variable "core_machine_type" {
  type        = string
  default     = "e2-standard-2"
  description = "VM instance type for mesh pool"
}

# define autoscaling parameters
variable "max_nodes_standard_pool" {
  type        = number
  default     = 10
  description = "Maximum size of standard pool"
}
variable "max_nodes_lightweight_pool" {
  type        = number
  default     = 10
  description = "Maximum size of lightweight pool"
}
variable "max_nodes_mesh_pool" {
  type        = number
  default     = 50
  description = "Maximum size of mesh pool"
}
variable "max_nodes_core_pool" {
  type        = number
  default     = 4
  description = "Maximum size of lightweight pool"
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

variable "letsencrypt_issuer_name" {
  type    = string
  default = "letsencrypt-staging"
  description = "which certificate issuer to configure cert-manager with"
}

variable "letsencrypt_server" {
  description = "ACME server URL"
  type        = string
  default     = "https://acme-v02.api.letsencrypt.org/directory"
}


