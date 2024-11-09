resource "google_storage_bucket" "ace-appstore-bucket-eicma-01" {
  name          = "ace-appstore-bucket-eicma-01"
  location      = "asia-south1"
  storage_class = "STANDARD"

  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "ace-appstore-bucket-eicma-02" {
  name          = "ace-appstore-bucket-eicma-02"
  location      = "asia-south1"
  storage_class = "STANDARD"

  uniform_bucket_level_access = true
  public_access_prevention = "inherited"
}

resource "google_storage_bucket" "ace-ota-bucket-eicma-01" {
  name          = "ace-ota-bucket-eicma-01"
  location      = "asia-south1"
  storage_class = "STANDARD"

  uniform_bucket_level_access = true
  public_access_prevention = "inherited"
}

resource "google_storage_bucket_iam_binding" "public_access" {
  bucket = google_storage_bucket.ace-appstore-bucket-eicma-01.name

  role   = "roles/storage.objectViewer"
  members = [
    "allUsers",
  ]
}

resource "google_storage_bucket_iam_member" "appstore_bucket_01_storage_admin" {
  bucket = google_storage_bucket.ace-appstore-bucket-eicma-01.name

  role   = "roles/storage.admin"
  member = "serviceAccount:${var.service_account_email}"
}

resource "google_storage_bucket_iam_member" "appstore_bucket_02_storage_admin" {
  bucket = google_storage_bucket.ace-appstore-bucket-eicma-02.name

  role   = "roles/storage.admin"
  member = "serviceAccount:${var.service_account_email}"
}

resource "google_storage_bucket_iam_member" "ota_bucket_01_storage_admin" {
  bucket = google_storage_bucket.ace-ota-bucket-eicma-01.name

  role   = "roles/storage.admin"
  member = "serviceAccount:${var.service_account_email}"
}