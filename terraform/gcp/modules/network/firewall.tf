resource "google_compute_firewall" "fw_rules" {
  count   = length(var.firewall_rules)
  project = var.vpc_project_name
  name    = var.firewall_rules[count.index].name
  network = google_compute_network.main.name

  allow {
    protocol = var.firewall_rules[count.index].protocol
    ports    = var.firewall_rules[count.index].ports
  }

  direction = var.firewall_rules[count.index].direction

  source_ranges = var.firewall_rules[count.index].source_ranges
  target_tags   = var.firewall_rules[count.index].target_tags
}