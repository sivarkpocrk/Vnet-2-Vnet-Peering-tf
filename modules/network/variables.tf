variable "env_prefix" {}
variable "location" {}
variable "resource_group_name" {}
variable "vnet_cidr" {}
variable "subnet_name" {}
variable "subnet_cidr" {}
variable "nsg_rules" {
  type = list(object({
    name     = string
    priority = number
    direction = string
    access   = string
    protocol = string
    source   = string
    port     = string
  }))
}
