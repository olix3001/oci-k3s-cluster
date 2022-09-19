data "http" "myip" {
    url = "https://ifconfig.me/ip"
}

data "template_file" "k3s" {
    template = file("./templates/hosts.template")
    vars = {
        k3s_master_ips = "${join("\n", [for instance in module.instances.masters : instance.public_ip])}"
        k3s_worker_ips = "${join("\n", [for instance in module.instances.workers : instance.public_ip])}"
    }
}

data "template_file" "k3s_ans_inv" {
    template = file("./templates/all.yml.template")
    vars = {
        k3s_master_ip = "${module.instances.masters[0].private_ip}"
    }
}