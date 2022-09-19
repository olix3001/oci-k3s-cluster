module "vcn" {
    source = "./modules/VCN"
    compartment_id = var.compartment_id
    allowed_ip_cidr = "${data.http.myip.response_body}/32"

    network_cidr_blocks = [ "10.0.0.0/24" ]
}

module "instances" {
    source = "./modules/instances"

    compartment_id = var.compartment_id
    kubernetes_subnet = module.vcn.kubernetes_subnet
    path_to_public_key = var.path_to_public_key
}


resource "local_file" "k3s_file" {
    content = data.template_file.k3s.rendered
    filename = "${var.ansible_path}/inventory/cluster/hosts.ini"
}

resource "local_file" "var_file" {
    content = data.template_file.k3s_ans_inv.rendered
    filename = "${var.ansible_path}/inventory/cluster/all.yml"
}