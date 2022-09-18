variable "compartment_id" {
    description = "OCI Compartment ID"
    type = string
}

variable "region" {
    description = "The region to connect to. Default: eu-frankfurt-1"
    type    = string
    default = "eu-frankfurt-1"
}

variable "user_ocid" {
    description = "User's OCID"
    type = string
}

variable "tenancy_ocid" {
    description = "Tenancy OCID"
    type = string
}

variable "allowed_ip_cidr" {
    description = "CIDR for the allowed ips"
    type = string
}

variable "path_to_public_key" {
    description = "Path to the public ssh key that will be allowed on the servers by default"
    type = string
}

variable "ansible_path" {
    description = "Path to the ansible directory"
    type = string
}


locals {
  flex_instance_config = {
    shape_id = "VM.Standard.A1.Flex"
    ocpus    = 2
    ram      = 12
  }
  micro_instance_config = {
    shape_id = "VM.Standard.E2.1.Micro"
    ocpus    = 1
    ram      = 1
  }
}