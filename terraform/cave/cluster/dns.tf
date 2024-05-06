
resource "google_dns_managed_zone" "primary" {
  name        = var.dns_zone
  dns_name    = "${var.domain_name}."
  description = "zone for ${var.domain_name}"
}

resource "google_dns_record_set" "a_records" {
  for_each = var.dns_entries

  name         = "${each.value.domain_name}."
  type         = "A"
  ttl          = 300
  managed_zone = each.value.zone
  rrdatas      = [google_compute_address.cluster_ip.address]

  provider = google
}