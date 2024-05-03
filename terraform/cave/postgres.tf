resource "google_sql_database_instance" "postgres" {
  name             = var.sql_instance_name
  region           = var.region
  database_version = "POSTGRES_13"

  lifecycle {
    prevent_destroy = true
  }
  settings {
    tier = "db-custom-${var.sql_instance_cpu}-${var.sql_instance_memory}"
  }
}

resource "google_sql_database" "annotation" {
  name     = "annotation"
  instance = google_sql_database_instance.postgres.name
}

resource "google_sql_database" "materialization" {
  name     = "materialization"
  instance = google_sql_database_instance.postgres.name
}

resource "google_sql_user" "writer" {
  name     = var.postgres_write_user
  instance = google_sql_database_instance.postgres.name
  password = var.postgres_user_password
}