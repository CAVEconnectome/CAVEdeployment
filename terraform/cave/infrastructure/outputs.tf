output "pcg_redis_host" {
  value       = google_redis_instance.pcg_redis.host
  description = "The ip of the pcg_redis host"
}

output "mat_redis_host" {
  value       = google_redis_instance.mat_redis.host
  description = "The ip of the mat_redis host"
}

output "network_self_link" {
  value       = google_compute_network.vpc.self_link
  description = "The self_link of the network"
}

output "subnetwork_self_link" {
  value       = google_compute_subnetwork.subnet.self_link
  description = "The self_link of the sub-network"
}

output "postgres_user" {
  value       = var.postgres_write_user
  description = "The username for the database writer"
}

output "postgres_password" {
  value       = var.postgres_user_password
  description = "The password for the database writer"
}

output "sql_instance_name" {
  value       = var.sql_instance_name
  description = "The name of the SQL instance"
}
