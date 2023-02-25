variable "default_server_ports" {
  description = "List of allowed ports"
  type        = list(any)
  default     = ["80", "22", "8080"]
}
