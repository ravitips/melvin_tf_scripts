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

variable "boot_disk_image" {
  description = "Image for the boot disk"
  type        = string
  default     = "ubuntu-2204-jammy-v20230714"
}

variable "boot_disk_size" {
  description = "Size of the boot disk in GB"
  type        = number
  default     = 100
}