variable "project_id" {
  description = "The ID of the project in which resources will be created."
  type        = string
}

variable "region" {
  description = "The region in which resources will be created."
  type        = string
}

variable "bucket_name" {
  description = "The name of the GCS bucket for storing the Terraform state."
  type        = string
}

variable "bucket_location" {
  description = "The location (region) of the GCS bucket."
  type        = string
}

variable "api_services" {
  description = "List of API services to enable for the project."
  type        = list(string)
}