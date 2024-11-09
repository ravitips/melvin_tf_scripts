provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_storage_bucket" "terraform_state" {
  name     = var.bucket_name
  location = var.bucket_location

  force_destroy               = false
  public_access_prevention    = "enforced"
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }
}

resource "google_project_service" "apis" {
  for_each = toset(var.api_services)
  project  = var.project_id
  service  = each.key
}