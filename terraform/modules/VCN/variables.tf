variable "network_cidr_blocks" {
    description = "CIDR blocks"
    type = list(string)
}

variable "compartment_id" { }
variable "allowed_ip_cidr" { }