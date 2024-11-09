resource "google_compute_address" "static_ip-appstore" {
  name   = "ace-appstore-vm-static-ip-01"
  region = var.region
}

resource "google_compute_address" "static_ip-ota" {
  name   = "ace-ota-vm-static-ip-01"
  region = var.region
}

resource "google_compute_instance" "ace-appstore-vm-01" {
  name         = "ace-appstore-vm-01"
  machine_type = "e2-highmem-4"
  zone         = var.zone

  tags = ["ace-appstore-vm-01","open-firewall"]

  boot_disk {
    initialize_params {
      image = var.boot_disk_image
      size  = var.boot_disk_size
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.static_ip-appstore.address
    }
  }
}

resource "google_compute_instance" "ace-ota-vm-01" {
  name         = "ace-ota-vm-01"
  machine_type = "e2-highmem-4"
  zone         = var.zone

  tags = ["ace-ota-vm-01","open-firewall"]

  boot_disk {
    initialize_params {
      image = var.boot_disk_image
      size  = var.boot_disk_size
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.static_ip-ota.address
    }
  }
}

resource "google_compute_firewall" "vm_firewall_open_all" {
  name    = "vm-firewall-open-all"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["open-firewall"]
}
