

resource "google_redis_instance" "pcg_redis" {
  name               = local.pcg_redis_name
  display_name       = local.pcg_redis_name
  tier               = "BASIC"
  memory_size_gb     = var.pcg_redis_memory_size_gb
  region             = var.region
  redis_version      = "REDIS_${var.redis_version}"
  project            = var.project_id
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

