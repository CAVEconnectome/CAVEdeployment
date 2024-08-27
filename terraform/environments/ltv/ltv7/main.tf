module "ltv-infrastructure" {
    source                     = "../../infrastructure"
    ## variables that must be defined
    # global google setup variables
    environment        = var.environment
    owner              = var.owner
    project_id         = var.project_id
    region             = var.region
    zone               = var.zone
    gcp_user_account   = var.gcp_user_account
    sql_instance_name  = var.sql_instance_name
    postgres_user_password = var.postgres_user_password
    pcg_redis_name     = var.pcg_redis_name
    postgres_write_user = var.postgres_write_user
    sql_instance_cpu   = var.sql_instance_cpu
    sql_instance_memory_gb = var.sql_instance_memory_gb
    sql_temp_file_limit_gb = var.sql_temp_file_limit_gb
}
