output "kubernetes_vcn" {
    value = oci_core_vcn.kubernetes_vcn
}

output "kubernetes_subnet" {
    value = oci_core_subnet.kubernetes_subnet
}