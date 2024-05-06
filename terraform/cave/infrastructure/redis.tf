

resource "google_redis_instance" "pcg_redis" {
  name               = "${var.owner}-${var.environment}-pcg-redis"
  display_name       = "${var.owner}-${var.environment}-pcg-redis"
  tier               = "BASIC"
  memory_size_gb     = var.pcg_redis_memory_size_gb
  region             = var.region
  redis_version      = "REDIS_${var.redis_version}_X"
  authorized_network = google_compute_network.vpc.self_link
  redis_configs =  {
    maxmemory-policy = "allkeys-lru"
    maxmemory-gb     = "0.98"
  }

  labels = {
    project = var.environment
    owner   = var.owner
  }
}

resource "google_redis_instance" "mat_redis" {
  name               = "${var.environment}-${terraform.workspace}-mat-redis"
  display_name       = "${var.environment}-${terraform.workspace}-mat-redis"
  tier               = "BASIC"
  memory_size_gb     = 1
  region             = var.region
  redis_version      = "REDIS_${var.redis_version}_X"
  authorized_network = google_compute_network.vpc.self_link

  labels = {
    project = var.environment
    owner   = var.owner
  }
}

