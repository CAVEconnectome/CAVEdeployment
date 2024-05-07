module "ltv-infrastructure" {
    source                     = "../../../cave/infrastructure"
    ## variables that must be defined
    # global google setup variables
    environment                = var.environment
    owner                      = var.owner
    project_id                 = var.project_id
    region                     = var.region
    zone                       = var.zone
    gcp_user_account           = var.gcp_user_account

    # postgres setup
    sql_instance_name          = var.sql_instance_name
    postgres_user_password     = var.postgres_user_password

    # pcg/l2cache setup variables
    pcg_redis_name             = var.pcg_redis_name

    # postgres variables with defaults
    postgres_write_user              = var.postgres_write_user
    sql_instance_cpu                 = var.sql_instance_cpu
    sql_instance_memory_gb           = var.sql_instance_memory_gb
    sql_temp_file_limit_gb           = var.sql_temp_file_limit_gb
    sql_work_mem_mb                  = var.sql_work_mem_mb
    sql_maintenance_work_mem_gb      = var.sql_maintenance_work_mem_gb

    # pcg variables with default
    pcg_redis_memory_size_gb   = var.pcg_redis_memory_size_gb

}
