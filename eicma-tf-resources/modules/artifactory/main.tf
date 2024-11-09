resource "google_artifact_registry_repository" "ace-eicma-reg-1" {
  location      = "asia-south1"
  repository_id = "ace-eicma-reg-1"
  description   =  "Docker Registry for EICMA"
  format        = "DOCKER"
}

resource "google_artifact_registry_repository_iam_member" "artifact_registry_reader" {
  repository = google_artifact_registry_repository.ace-eicma-reg-1.name
  role       = "roles/artifactregistry.reader"
  member     = "serviceAccount:${var.service_account_email}"
}

resource "google_artifact_registry_repository_iam_member" "artifact_registry_writer" {
  repository = google_artifact_registry_repository.ace-eicma-reg-1.name
  role       = "roles/artifactregistry.writer"
  member     = "serviceAccount:${var.service_account_email}"
}
