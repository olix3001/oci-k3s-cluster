resource "oci_core_security_list" "kubernetes_security_list" {
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.kubernetes_vcn.id

    // ssh
    ingress_security_rules {
        protocol = 6
        source = var.allowed_ip_cidr

        tcp_options {
            min = 22
            max = 22
        }
    }

    // http / https
    ingress_security_rules {
        protocol = 6
        source = "0.0.0.0/0"

        tcp_options {
            min = 80
            max = 80
        }
    }
    ingress_security_rules {
        protocol = 6
        source = "0.0.0.0/0"

        tcp_options {
            min = 443
            max = 443
        }
    }

    // traefik
    ingress_security_rules {
        protocol = 6
        source = "0.0.0.0/0"

        tcp_options {
            min = 8080
            max = 8080
        }
    }


    // kubernetes
    ingress_security_rules {
        protocol = 6
        source = var.allowed_ip_cidr

        tcp_options {
            min = 6443
            max = 6443
        }
    }

    // inside own network
    ingress_security_rules {
        protocol = "all"
        source   = var.network_cidr_blocks[0]

        description = "Allow all from vcn subnet"
    }

    // icmp for oracle
    ingress_security_rules {
        protocol = 1 # icmp
        source   = var.allowed_ip_cidr
        description = "Allow icmp from  ${var.allowed_ip_cidr}"
    }

    // all outgoing
    egress_security_rules {
        destination = "0.0.0.0/0"
        protocol = "all"
    }
}