variable "vm_project_name" {
  type        = string
  description = "GCP VM project name"
}

variable "gce_region" {
  type = string
  description = "GCE region"
  default = "us-central1"
}

variable "vm_subnetwork" {
  type = string
  description = "VM subnetwork name"
}

variable "vm_properties" {
  type        = any
  description = "VM Properties"
  default     = []
}

variable "ssh_user" {
  type = string
  description = "Jenkins SSH User"
  default = "jenkins"
}

variable "ssh_pub_key_file" {
  type = string
  description = "Public key for Jenkins SSH User"
}