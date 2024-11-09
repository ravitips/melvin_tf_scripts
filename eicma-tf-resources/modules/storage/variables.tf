variable "region" {
  type        = string
  description = "The region to deploy resources in"
  default     = "asia-south1"
}

variable "zone" {
  description = "Zone for the instance"
  type        = string
  default     = "asia-south1-a"
}

variable "service_account_email" {
  description = "The email of the service account to be given Storage Admin role"
  type        = string
}