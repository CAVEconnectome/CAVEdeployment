resource "google_container_node_pool" "sp" {
  name       = "standard-pool"
  location   = var.zone
  cluster    = google_container_cluster.cluster.name
  node_count = 1

  node_config {
    labels = {
      project = var.environment
      owner   = var.owner
    }

    machine_type = var.standard_machine_type
    disk_size_gb = 20
    preemptible = false
    
    metadata = {
      disable-legacy-endpoints = "true"
    }
    service_account = google_service_account.workload_identity.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
  autoscaling {
    min_node_count = 1
    max_node_count = var.max_nodes_standard_pool
  }
}

resource "google_container_node_pool" "lp" {
  name       = "lightweight-pool"
  location   = var.zone
  cluster    = google_container_cluster.cluster.name

  node_config {
    labels = {
      project = var.environment
      owner   = var.owner
    }

    machine_type = var.lightweight_machine_type
    disk_size_gb = 20
    preemptible  = true
    
    metadata = {
      disable-legacy-endpoints = "true"
    }
    service_account = google_service_account.workload_identity.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
  autoscaling {
    min_node_count = 1
    max_node_count = var.max_nodes_lightweight_pool
  }
}


resource "google_container_node_pool" "mp" {
  name       = "mesh-pool"
  location   = var.zone
  cluster    = google_container_cluster.cluster.name

  node_config {
    labels = {
      project = var.environment
      owner   = var.owner
    }

    machine_type = var.mesh_machine_type
    disk_size_gb = 20
    preemptible  = true
    
    metadata = {
      disable-legacy-endpoints = "true"
    }
    service_account = google_service_account.workload_identity.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
  autoscaling {
    min_node_count = 1
    max_node_count = var.max_nodes_mesh_pool
  }
}


resource "google_container_node_pool" "cp" {
  name       = "core-pool"
  location   = var.zone
  cluster    = google_container_cluster.cluster.name

  node_config {
    labels = {
      project = var.environment
      owner   = var.owner
    }

    machine_type = var.core_machine_type
    disk_size_gb = 20
    preemptible  = false
    
    metadata = {
      disable-legacy-endpoints = "true"
    }
    service_account = google_service_account.workload_identity.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
  autoscaling {
    min_node_count = 1
    max_node_count = var.max_nodes_core_pool
  }
}