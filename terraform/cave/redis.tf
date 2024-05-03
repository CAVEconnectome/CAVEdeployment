

resource "google_redis_instance" "pcg_redis" {
  name               = var.pcg_redis_name
  display_name       = var.pcg_redis_name
  tier               = "BASIC"
  memory_size_gb     = var.pcg_redis_memory_size_gb
  region             = var.region
  redis_version      = "REDIS_7_X"
  authorized_network = google_compute_network.vpc.name
  redis_configs =  {
    maxmemory-policy = "allkeys-lru"
    maxmemory-gb     = "0.98"
  }
  lifecycle {
    prevent_destroy = true
  }

  labels = {
    project = var.environment
    owner   = var.owner
  }
}

resource "google_redis_instance" "mat_redis" {
  name               = "mat-redis-${var.environment}-${terraform.workspace}"
  display_name       = "mat-redis-${var.environment}-${terraform.workspace}"
  tier               = "BASIC"
  memory_size_gb     = 1
  region             = var.region
  redis_version      = "REDIS_7_X"
  authorized_network = google_compute_network.vpc.name

  labels = {
    project = var.environment
    owner   = var.owner
  }
}

