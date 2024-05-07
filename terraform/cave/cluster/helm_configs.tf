resource "local_file" "helmfile" {
  filename = "${var.helm_config_dir}/helmfile.yaml"
  content  = templatefile("${path.module}/templates/helmfile.tpl", {
    postgres_user       = var.postgres_write_user
    postgres_password   = var.postgres_user_password
  })
}

resource "local_file" "cloudsql_helm_values" {
  filename = "${var.helm_config_dir}/cloudsql.yaml"
  content  = templatefile("${path.module}/templates/cloudsql.tpl", {
    sql_instance_name   = var.sql_instance_name
    postgres_user       = var.postgres_write_user
    postgres_password   = var.postgres_user_password

  })
}

resource "local_file" "materialization_schedule" {
  filename = "${var.helm_config_dir}/materialization_schedule.tpl.json"
  content  = templatefile("${path.module}/templates/materialization_schedule.json", {
  })
}

resource "local_file" "pcg_helm_values" {
  filename = "${var.helm_config_dir}/pychunkedgraph.yaml"
  content  = templatefile("${path.module}/templates/pychunkedgraph.tpl", {
    redis_ip = google_redis_instance.pcg_redis.host
    big_table_instance_name = var.bigtable_instance_name
    remesh_queue = google_pubsub_subscription.pychunkedgraph_remesh.name
  })
}

resource "local_file" "limiter_helm_values" {
  filename = "${var.helm_config_dir}/limiter.yaml"
  content  = templatefile("${path.module}/templates/limiter.tpl", {
    redis_ip = google_redis_instance.mat_redis.host
  })
}

resource "local_file" "annotation_helm_values" {
  filename = "${var.helm_config_dir}/annotation.yaml"
  content  = templatefile("${path.module}/templates/annotation.tpl", {
  })
}

resource "local_file" "dash_helm_values" {
  filename = "${var.helm_config_dir}/dash.yaml"
  content  = templatefile("${path.module}/templates/dash.tpl", {
  })
}

resource "local_file" "cluster_helm_values" {
  filename = "${var.helm_config_dir}/cluster.yaml"
  content  = templatefile("${path.module}/templates/cluster.tpl", {
      environment = var.environment
      domain_name = var.domain_name
      project_id = var.project_id
      data_project_id = coalesce(var.bigtable_google_project, var.project_id)
      mesh_pool = google_container_node_pool.mp.name
      standard_pool = google_container_node_pool.sp.name
      lightweight_pool = google_container_node_pool.lp.name
      core_pool = google_container_node_pool.cp.name  
      googleRegion = var.region 
      googleZone = var.zone
  })
}

resource "local_file" "materialize_helm_values" {
  filename = "${var.helm_config_dir}/materialize.yaml"
  content  = templatefile("${path.module}/templates/materialize.tpl", {
    redis_ip = google_redis_instance.mat_redis.host
  })
}