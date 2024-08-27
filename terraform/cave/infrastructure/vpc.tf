resource "google_compute_network" "vpc" {
  name                     = local.vpc_name
  project                  = var.project_id
  routing_mode             = "REGIONAL"
  auto_create_subnetworks  = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${google_compute_network.vpc.name}-sub"
  project       = var.project_id
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.142.0.0/20"
}