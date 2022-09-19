// VCN SETUP
resource "oci_core_vcn" "kubernetes_vcn" {
    compartment_id = var.compartment_id
  
    cidr_blocks = var.network_cidr_blocks
    display_name = "kubernetes-vcn"
    dns_label    = "internal"
}

resource "oci_core_internet_gateway" "internet_gateway" {
    compartment_id = var.compartment_id
    vcn_id         = oci_core_vcn.kubernetes_vcn.id
    enabled        = true
}

resource "oci_core_default_route_table" "internet_route_table" {
    compartment_id             = var.compartment_id
    manage_default_resource_id = oci_core_vcn.kubernetes_vcn.default_route_table_id

    route_rules {
        network_entity_id = oci_core_internet_gateway.internet_gateway.id
        destination       = "0.0.0.0/0"
        destination_type  = "CIDR_BLOCK"
    }
}

// SUBNET SETUP
resource "oci_core_subnet" "kubernetes_subnet" {
    cidr_block = var.network_cidr_blocks[0]
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.kubernetes_vcn.id

    security_list_ids = [ oci_core_security_list.kubernetes_security_list.id ]

    display_name = "kubernetes-subnet"
}