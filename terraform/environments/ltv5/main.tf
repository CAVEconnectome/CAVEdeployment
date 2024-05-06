module "cave" {
    source                     = "../../cave"
    ## variables that must be defined
    # global google setup variables
    environment                = var.environment
    owner                      = var.owner
    project_id                 = var.project_id
    region                     = var.region
    zone                       = var.zone
    gcp_user_account           = var.gcp_user_account

    # dns variables
    domain_name                = var.domain_name
    dns_zone                   = var.dns_zone
    dns_entries                = var.dns_entries
    letsencrypt_email          = var.letsencrypt_email
    
    # postgres setup
    sql_instance_name          = var.sql_instance_name
    postgres_user_password     = var.postgres_user_password

    # pcg/l2cache setup variables
    bigtable_instance_name     = var.bigtable_instance_name
    pcg_bucket_name            = var.pcg_bucket_name
    bigtable_google_project    = var.bigtable_google_project
    pcg_redis_name             = var.pcg_redis_name

    ## variables with defaults
    # kubernetes cluster variables
    standard_machine_type      = var.standard_machine_type
    lightweight_machine_type   = var.lightweight_machine_type
    mesh_machine_type          = var.mesh_machine_type
    core_machine_type          = var.core_machine_type
    max_nodes_standard_pool    = var.max_nodes_standard_pool
    max_nodes_lightweight_pool = var.max_nodes_lightweight_pool
    max_nodes_mesh_pool        = var.max_nodes_mesh_pool
    max_nodes_core_pool        = var.max_nodes_core_pool
    
    # postgres variables with defaults
    postgres_write_user              = var.postgres_write_user
    sql_instance_cpu                 = var.sql_instance_cpu
    sql_instance_memory_gb           = var.sql_instance_memory_gb
    sql_temp_file_limit_gb           = var.sql_temp_file_limit_gb
    sql_work_mem_mb                  = var.sql_work_mem_mb
    sql_maintenance_work_mem_gb      = var.sql_maintenance_work_mem_gb

    # pcg variables with default
    pcg_redis_memory_size_gb   = var.pcg_redis_memory_size_gb

    # dns setup with defaults
    letsencrypt_issuer_name    = var.letsencrypt_issuer_name
    letsencrypt_server         = var.letsencrypt_server
}
