resource "google_compute_instance" "jenkins" {
  count        = length(local.vms)
  project      = var.vm_project_name
  name         = local.vms[count.index].name
  machine_type = local.vms[count.index].machine_type
  zone         = local.vms[count.index].zone

  tags   = local.vms[count.index].tags
  labels = local.vms[count.index].labels

  boot_disk {
    initialize_params {
      image = local.vms[count.index].image
      size  = local.vms[count.index].boot_disk_size
    }
  }

  network_interface {
    subnetwork_project = var.vm_project_name
    subnetwork = var.vm_subnetwork
    dynamic "access_config" {
      for_each = local.vms[count.index].public_ip == true ? [1] : []
      content {}
    }
  }

  metadata_startup_script = templatefile("templates/startup.tmpl",
    {
      jenkins_image_url = var.jenkins_image_url
      jenkins_version = var.jenkins_version
    })

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_pub_key_file)}"
  }
}