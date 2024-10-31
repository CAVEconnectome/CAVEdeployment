resource "random_id" "default" {
  byte_length = 8
}

resource "google_storage_bucket" "default" {
  name     = var.terraform_bucket_name
  project = var.project_id
  location = "US"

  force_destroy               = false
  public_access_prevention    = "enforced"
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }
}
# [END storage_bucket_tf_with_versioning_pap_uap_no_destroy]

# [START storage_remote_backend_local_file]
resource "local_file" "default" {
  file_permission = "0644"
  filename        = "${path.module}/backend.tf"

  # You can store the template in a file and use the templatefile function for
  # more modularity, if you prefer, instead of storing the template inline as
  # we do here.
  content = <<-EOT
  terraform {
    backend "gcs" {
      bucket = "${google_storage_bucket.default.name}"
      prefix = "ltv/infrastructure/"
    }
  }
  EOT
}

module "infrastructure" {
    source                     = "../../../cave/infrastructure"
    ## variables that must be defined
    # global google setup variables
    environment                = var.environment
    owner                      = var.owner
    project_id                 = var.project_id
    region                     = var.region

    # postgres setup
    sql_instance_name          = var.sql_instance_name
    postgres_user_password     = var.postgres_user_password

    # pcg/l2cache setup variables
    pcg_redis_name_override         = var.pcg_redis_name

    # postgres variables with defaults
    postgres_write_user              = var.postgres_write_user
    sql_instance_cpu                 = var.sql_instance_cpu
    sql_instance_memory_gb           = var.sql_instance_memory_gb
    sql_temp_file_limit_gb           = var.sql_temp_file_limit_gb
    sql_work_mem_mb                  = var.sql_work_mem_mb
    sql_maintenance_work_mem_gb      = var.sql_maintenance_work_mem_gb

    # pcg variables with default
    pcg_redis_memory_size_gb   = var.pcg_redis_memory_size_gb
    vpc_name_override          = var.vpc_name
}
