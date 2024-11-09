resource "google_compute_global_address" "private_ip_range" {
  name          = "private-ip-range"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = "projects/ace-eicma/global/networks/default"
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = "projects/ace-eicma/global/networks/default"
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_range.name]
}

resource "google_sql_database_instance" "ace-ota-db-01" {
  name             = "ace-ota-db-01"
  database_version = "POSTGRES_15"
  region           = "asia-south1"

  depends_on = [google_service_networking_connection.private_vpc_connection]

  settings {
    tier            = "db-custom-2-8192"  # 2 vCPUs and 8 GB memory
    disk_size       = 15  # Disk size in GB
    disk_type       = "PD_SSD"
    activation_policy  = "ALWAYS"

    ip_configuration {
      ipv4_enabled = true  # Enables Public IP
      private_network = "projects/ace-eicma/global/networks/default"  # Default network for Private IP

      # Add the authorized network for external access
      authorized_networks {
        name  = "EB Office IP"
        value = "115.110.170.171"
      }
    }

    backup_configuration {
      enabled                        = true  # Automated backups
      point_in_time_recovery_enabled = true  # Point-in-time recovery
    }

    availability_type = "ZONAL"  # Single zone availability
  }

  deletion_protection = false
}

resource "google_sql_user" "ace_user" {
  name     = "ace-user"
  instance = google_sql_database_instance.ace-ota-db-01.name
  password = "qwerty@123"  # Replace with your desired password
}

resource "google_sql_database" "ota_db" {
  name     = "ota_db"
  instance = google_sql_database_instance.ace-ota-db-01.name
}

resource "google_sql_database" "im_db" {
  name     = "im_db"
  instance = google_sql_database_instance.ace-ota-db-01.name
}

