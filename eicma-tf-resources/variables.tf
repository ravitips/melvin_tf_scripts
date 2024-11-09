variable "project_id" {
  type        = string
  description = "The ID of the project to deploy resources in."
  default     = "ace-eicma"
}

variable "region" {
  type        = string
  description = "The region to deploy resources in."
  default     = "asia-south1"
}

variable "backend_bucket_name" {
  description = "The name of the GCS bucket for Terraform state storage."
  type        = string
  default     = "eicma-tf-state-bucket"
}

variable "backend_prefix" {
  description = "The prefix directory within the GCS bucket where Terraform state files will be stored."
  type        = string
  default     = "terraform/state"
}
