
resource "google_pubsub_topic" "l2cache" {
  name = "${var.environment}_L2CACHE"
}

resource "google_pubsub_subscription" "l2cache_update" {
  name    =  "${var.environment}_L2CACHE_WORKER"
  topic   = google_pubsub_topic.l2cache.name
  ack_deadline_seconds = 60
  expiration_policy {
    ttl = "never"
  }
  retry_policy {
    maximum_backoff = "10s"
  }
}

resource "google_pubsub_topic" "pychunkedgraph_edits" {
  name ="${var.environment}_PCG_EDIT"
}

resource "google_pubsub_subscription" "pychunkedgraph_remesh" {
  name    = "${var.environment}_PCG_HIGH_PRIORITY_REMESH"
  topic   = google_pubsub_topic.pychunkedgraph_edits.name
  ack_deadline_seconds = 600
  expiration_policy {
    ttl = "never"
  }
  retry_policy {
    maximum_backoff = "10s"
  }
  filter = "attributes.remesh_priority=\"true\""
}

resource "google_pubsub_subscription" "pychunkedgraph_low_priority_remesh" {
  name    = "${var.environment}_PCG_LOW_PRIORITY_REMESH"
  topic   = google_pubsub_topic.pychunkedgraph_edits.name
  ack_deadline_seconds = 600
  expiration_policy {
    ttl = "never"
  }
  retry_policy {
    maximum_backoff = "10s"
  }
  filter = "attributes.remesh_priority=\"false\""
}

resource "google_pubsub_subscription" "l2cache_trigger" {
  name    = "${var.environment}_${terraform.workspace}_L2CACHE_HIGH_PRIORITY_TRIGGER"
  topic   = google_pubsub_topic.pychunkedgraph_edits.name
  ack_deadline_seconds = 600
  expiration_policy {
    ttl = "never"
  }
  retry_policy {
    maximum_backoff = "10s"
  }
  filter = "attributes.remesh_priority=\"true\""
}

resource "google_pubsub_subscription" "l2cache_trigger_low_priority" {
  name    = "${var.environment}_${terraform.workspace}_L2CACHE_LOW_PRIORITY_TRIGGER"
  topic   = google_pubsub_topic.pychunkedgraph_edits.name
  ack_deadline_seconds = 600
  expiration_policy {
    ttl = "never"
  }
  retry_policy {
    maximum_backoff = "10s"
  }
  filter = "attributes.remesh_priority=\"false\""
}