locals {
  env_name    = split("-", var.vm_project_name)[0]
  env_purpose = split("-", var.vm_project_name)[1]
  env_type    = split("-", var.vm_project_name)[2]
  iteration   = split("-", var.vm_project_name)[3]

  vms = flatten([
    for vm in var.vm_properties : {
      "name" = format("%s-%s-%s-%s-%s",
        local.env_name,
        local.env_purpose,
        vm.short_name,
        local.env_type,
        local.iteration
      )
      "machine_type"   = vm.machine_type
      "zone"           = format("%s-%s", var.gce_region, vm.zone_letter)
      "boot_disk_size" = vm.boot_disk_size
      "image"          = vm.boot_disk_image
      "public_ip"      = vm.public_ip
      "tags"           = vm.tags
      "labels"         = vm.labels
    }
  ])
}