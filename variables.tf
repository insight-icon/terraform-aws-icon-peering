variable "environment" {
  type = string
}

variable "acceptor_vpc_id" {
  type = string
}

variable "acceptor_route_table_id" {
  type = string
}
variable "acceptor_vpc_cidr_block" {
  type = string
}

variable "requestor_vpc_id" {
  type = string
}

variable "requestor_route_table_id" {
  type = string
}

variable "requestor_vpc_cidr_block" {
  type = string
}

variable "name" {
  type = string
}

variable "tags" {
  type = map(string)
  default = {}
  description = "Additional tags (e.g. map('BusinessUnit`,`XYZ`)"
}

variable "auto_accept" {
  default = "true"
  description = "Automatically accept the peering (both VPCs need to be in the same AWS account)"
}

variable "acceptor_allow_remote_vpc_dns_resolution" {
  default = "true"
  description = "Allow acceptor VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the requestor VPC"
}

variable "requestor_allow_remote_vpc_dns_resolution" {
  default = "true"
  description = "Allow requestor VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the acceptor VPC"
}

