
variable "environment" {
  description = "environment name to identify resources"
}

variable "region" {
  description = "region"
}

variable "owner" {
  type = string
  description = "added as label to resources, convenient to filter costs based on labels"
  default = "na"
}

variable "project_id" {
  description = "google project id"
}


variable "sql_instance_name" {
  description = "Name of the SQL instance"
  type = string
}

variable "postgres_user_password" {
  description = "Password for the database writer"
  type = string
  sensitive = true
}

variable "pcg_redis_name_override" {
  description = "Override for the PCG Redis name"
  type        = string
  default     = ""
}

variable "vpc_name_override" {
  description = "Override for the VPC name"
  type        = string
  default     = ""
}

locals {
  pcg_redis_name = var.pcg_redis_name_override != "" ? var.pcg_redis_name_override : "${var.owner}-${var.environment}-pcg-redis"
  vpc_name = var.vpc_name_override != "" ? var.vpc_name_override : "${var.owner}-${var.environment}-vpc"
}

variable "postgres_write_user" {
  description = "Username for the database writer"
  default = "postgres"
  sensitive = true
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


variable "pcg_redis_memory_size_gb" {
  type        = number
  default     = 1
  description = "redis instance size"
}

variable "redis_version" {
  type        = string
  default     = "7_2"
  description = "redis version"
}