output "masters" {
    value = oci_core_instance.master_servers
}

output "workers" {
    value = oci_core_instance.worker_servers
}