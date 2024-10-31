

resource "google_service_account" "workload_identity" {
  project = var.project_id

  account_id   = "svc-workident-${var.cluster_name}"
  display_name = "svc-workident-${var.cluster_name}"
}

# resource "kubernetes_service_account" "ksa" {
#   metadata {
#     name      = "my-service-account"
#     namespace = "default"
#     annotations = {
#       "iam.gke.io/gcp-service-account" = google_service_account.workload_identity.email
#     }
#   }

#   automount_service_account_token = true
# }

resource "google_service_account_iam_binding" "ksa_gsa_binding" {
  service_account_id = google_service_account.workload_identity.email
  role               = "roles/iam.workloadIdentityUser"
  members            = ["serviceAccount:${var.project_id}.svc.id.goog[default/my-service-account]"]
}

resource "google_container_cluster" "cluster" {
  name                     = "${var.cluster_name}-cave"
  location                 = var.zone
  remove_default_node_pool = true
  initial_node_count       = 1

  network         = var.network
  subnetwork      = var.subnetwork
  networking_mode = "VPC_NATIVE"

  resource_labels = {
    project = var.environment
    owner   = var.owner
  }

  release_channel {
    channel = "STABLE"
  }

  ip_allocation_policy {}

  addons_config {
    http_load_balancing {
      disabled = true
    }
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }

  node_config {
   service_account = google_service_account.workload_identity.email
   oauth_scopes = [
    "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}


# resource "kubernetes_cluster_role_binding" "cluster_admin_binding" {

#   metadata {
#     name = "cluster-admin-binding"
#   }
#   role_ref {
#     api_group = "rbac.authorization.k8s.io"
#     kind      = "ClusterRole"
#     name      = "cluster-admin"
#   }
#   subject {
#     kind      = "User"
#     name      = var.gcp_user_account
#     api_group = "rbac.authorization.k8s.io"
#   }
# }

resource "google_compute_address" "cluster_ip" {
  name   = "${var.cluster_name}-cave"
  region = var.region

}

# data "google_client_config" "default" {}


# provider "kubectl" {
#   host                   = google_container_cluster.cluster.endpoint
#   token                  = data.google_client_config.default.access_token
#   cluster_ca_certificate = base64decode(google_container_cluster.cluster.master_auth[0].cluster_ca_certificate)
#   load_config_file       = false
# }

# provider "helm" {
#   kubernetes {
#     host                   = google_container_cluster.cluster.endpoint
#     token                  = data.google_client_config.default.access_token
#     cluster_ca_certificate = base64decode(google_container_cluster.cluster.master_auth[0].cluster_ca_certificate)
#   }
# }