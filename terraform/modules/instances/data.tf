data "oci_core_images" "ubuntu_aarch64_os_images" {
  compartment_id = var.compartment_id
  operating_system = "Canonical Ubuntu"
  filter {
    name = "display_name"
    values = ["^Canonical-Ubuntu-22.04-aarch64-([\\.0-9-]+)$"]
    regex = true
  }
}

data "oci_core_images" "ubuntu_os_images" {
  compartment_id = var.compartment_id
  operating_system = "Canonical Ubuntu"
  filter {
    name = "display_name"
    values = ["^Canonical-Ubuntu-22.04-([\\.0-9-]+)$"]
    regex = true
  }
}

data "oci_identity_availability_domain" "masters_ad" {
  compartment_id = var.compartment_id
  ad_number      = 2
} 
data "oci_identity_availability_domain" "workers_ad" {
  compartment_id = var.compartment_id
  ad_number      = 3
}