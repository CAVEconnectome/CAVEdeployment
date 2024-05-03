resource "helm_release" "nginx_ingress" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "1.41.3"

  set {
    name  = "controller.service.loadBalancerIP"
    value = google_compute_address.cluster_ip.address
  }

  set {
    name  = "controller.service.externalTrafficPolicy"
    value = "Local"
  }

  depends_on = [google_compute_address.cluster_ip]
}

resource "kubernetes_namespace" "cert_manager" {
  metadata {
    name = "cert-manager"
  }
}

resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io/jetstack"
  chart      = "cert-manager"
  version    = "1.8.0"
  namespace  = kubernetes_namespace.cert_manager.metadata[0].name

  set {
    name  = "installCRDs"
    value = "true"
  }

  set {
    name  = "ingressShim.defaultIssuerName"
    value = var.letsencrypt_issuer_name
  }

  set {
    name  = "ingressShim.defaultIssuerKind"
    value = "ClusterIssuer"
  }

}

resource "google_service_account" "cloud_dns_sa" {
  account_id   = "clouddns-${var.environment}"
  display_name = "clouddns-${var.environment}"
  project      = var.project_id
}

resource "google_service_account_key" "cloud_dns_sa_key" {
  service_account_id = google_service_account.cloud_dns_sa.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}

resource "google_project_iam_member" "cloud_dns_role" {
  project = var.project_id
  role    = "roles/dns.admin"
  member  = "serviceAccount:${google_service_account.cloud_dns_sa.email}"
}


resource "kubernetes_secret" "cloud_dns_secret" {
  metadata {
    name = "clouddns-${var.environment}-secret"
  }

  data = {
    "google-secret.json" = base64encode(google_service_account_key.cloud_dns_sa_key.private_key)
  }

  depends_on = [
    helm_release.cert_manager
  ]
}

resource "kubernetes_manifest" "issuer" {
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "Issuer"
    metadata = {
      name = var.letsencrypt_issuer_name
    }
    spec = {
      acme = {
        server = var.letsencrypt_server
        email  = var.letsencrypt_email
        privateKeySecretRef = {
          name = var.letsencrypt_issuer_name
        }
        solvers = [
          {
            dns01 = {
              cloudDNS = {
                project = var.project_id
                serviceAccountSecretRef = {
                  name = kubernetes_secret.cloud_dns_secret.metadata[0].name
                  key  = "google-secret.json"
                }
              }
            }
          }
        ]
      }
    }
  }

  depends_on = [
    kubernetes_secret.cloud_dns_secret
  ]
}

resource "kubectl_manifest" "certificate" {
  yaml_body = templatefile("${path.module}/templates/certificate.tmpl.yaml", {
    environment = var.environment
    issuer_name = var.letsencrypt_issuer_name
    dns_names   = [for _, entry in var.dns_entries : entry.domain_name]
  })
  depends_on = [
    kubernetes_manifest.issuer
  ]
  provisioner "local-exec" {
    command = "until kubectl get issuer ${var.letsencrypt_issuer_name} -n ${kubernetes_namespace.cert_manager.metadata[0].name} -o jsonpath='{.status.conditions[?(@.type==\"Ready\")].status}' | grep True; do echo waiting for issuer to be ready; sleep 10; done"
  }
}