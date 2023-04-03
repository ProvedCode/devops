resource "google_compute_network" "main" {
  project = var.vpc_project_name
  name = local.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "jenkins_subnet" {
  project = var.vpc_project_name
  name = local.jenkins_subnet_name
  ip_cidr_range = var.jenkins_subnet_ip_cidr_range
  region = var.jenkins_subnet_region
  network = google_compute_network.main.id
}