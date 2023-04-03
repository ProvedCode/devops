variable "region" {
  type        = string
  description = "GCP region, possible values below"
  default     = "us-central1"
  # "asia-east1"
  # "asia-east"
  # "asia-northeast1"
  # "asia-northeast2"
  # "asia-northeast3"
  # "asia-south1"
  # "asia-southeast1"
  # "asia-southeast2"
  # "australia-southeast1"
  # "europe-north1"
  # "europe-west1"
  # "europe-west2"
  # "europe-west3"
  # "europe-west4"
  # "europe-west6"
  # "northamerica-northeast1"
  # "southamerica-east1"
  # "us-central1"
  # "us-east1"
  # "us-east4"
  # "us-west1"
  # "us-west2"
  # "us-west3"
  # "us-west4"
}

variable "project_name" {
  type        = string
  description = "GCP project name"
}

variable "jenkins_ip_cidr_range" {
  type = string
  description = "IP CIDR range for Jenkins subnet"
  default = "10.196.0.0/20"
}

variable "jenkins_firewall_rules" {
  type        = any
  description = "Firewall Rules for Jenkins VM"
  default     = []
}

variable "gce_vm_ssh_pub_key_file" {
  type = string
  description = "Server's user SSH public key"
}

variable "gce_vm_properties" {
  type = any
  description = "GCE VM properties"
  default = []
}