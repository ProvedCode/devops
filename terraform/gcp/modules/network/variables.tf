variable "vpc_project_name" {
  description = "VPC project name"
  type = string
}

variable "jenkins_subnet_region" {
  description = "Jenkins subnet region"
  type = string
  default = "us-central1"
}

variable "jenkins_subnet_ip_cidr_range" {
  description = "IP CIDR range for Jenkins subnet"
  type = string
  default = "10.196.0.0/20"
}

variable "firewall_rules" {
  type        = any
  description = "Firewall Rules"
  default     = []
}