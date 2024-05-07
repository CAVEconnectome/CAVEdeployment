resource "google_redis_instance" "mat_redis" {
  name               = "${var.cluster_name}-mat-redis"
  display_name       = "${var.cluster_name}-mat-redis"
  tier               = "BASIC"
  memory_size_gb     = 1
  region             = var.region
  redis_version      = "REDIS_${var.redis_version}_X"
  authorized_network = var.network

  labels = {
    project = var.environment
    owner   = var.owner
  }
}
