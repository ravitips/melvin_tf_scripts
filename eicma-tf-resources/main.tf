terraform {
  backend "gcs" {
    bucket = "eicma-tf-state-bucket"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

module "iam_svc" {
  source = "./modules/iam_svc"
}

module "compute_engine" {
  source = "./modules/compute_engine"
}

module "artifactory" {
  source                 = "./modules/artifactory"
  service_account_email  = module.iam_svc.service_account_email
}

module "storage" {
  source                 = "./modules/storage"
  service_account_email  = module.iam_svc.service_account_email
}

module "sql_db" {
  source = "./modules/sql_db"
}