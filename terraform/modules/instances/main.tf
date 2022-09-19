resource "oci_core_instance" "master_servers" {
    count = 2

    availability_domain = data.oci_identity_availability_domain.masters_ad.name
    compartment_id = var.compartment_id
    shape = "VM.Standard.A1.Flex"
    display_name = "kubernetes-master-${count.index + 1}"

    shape_config {
        ocpus = 2
        memory_in_gbs = 12
    }

    source_details {
        source_id   = data.oci_core_images.ubuntu_aarch64_os_images.images.0.id
        source_type = "image"
        boot_volume_size_in_gbs = "50"
    }

    create_vnic_details {
        subnet_id  = var.kubernetes_subnet.id
        private_ip = "10.0.0.${count.index + 100}"
    }


    // cloudinit
    metadata = {
        user_data = base64encode(
            templatefile("${path.module}/templates/ubuntu.template.yml", {
                ssh_authorized_keys = file(var.path_to_public_key)
            })
        )
    }

    connection {
        type = "ssh"
        user = "kube"
        host = self.public_ip
    }

    provisioner "remote-exec" {
        inline = [
            "cloud-init status --wait"
        ]
    }
}

resource "oci_core_instance" "worker_servers" {
    count = 1

    availability_domain = data.oci_identity_availability_domain.workers_ad.name
    compartment_id = var.compartment_id
    shape = "VM.Standard.E2.1.Micro"
    display_name = "kubernetes-worker-${count.index + 1}"

    shape_config {
        ocpus = 1
        memory_in_gbs = 1
    }

    source_details {
        source_id   = data.oci_core_images.ubuntu_os_images.images.0.id
        source_type = "image"
        boot_volume_size_in_gbs = "50"
    }

    create_vnic_details {
        subnet_id  = var.kubernetes_subnet.id
        private_ip = "10.0.0.${count.index + 150}"
    }

    // cloudinit
    metadata = {
        user_data = base64encode(
            templatefile("${path.module}/templates/ubuntu.template.yml", {
                ssh_authorized_keys = file(var.path_to_public_key)
            })
        )
    }

    connection {
        type = "ssh"
        user = "kube"
        host = self.public_ip
    }

    provisioner "remote-exec" {
        inline = [
            "cloud-init status --wait"
        ]
    }
}