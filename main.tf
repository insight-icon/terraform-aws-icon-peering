data "aws_caller_identity" "this" {}
data "aws_region" "current" {}

terraform {
  required_version = ">= 0.12"
}

locals {
  name = var.name
  common_tags = {
    "Name" = local.name
    "Terraform" = true
    "Environment" = var.environment
  }

  tags = merge(var.tags, local.common_tags)
}

data "aws_vpc" "acceptor" {
  id = var.acceptor_vpc_id
}

data "aws_vpc" "requestor" {
  id = var.requestor_vpc_id
}

data "aws_route_tables" "acceptor" {
  vpc_id = var.acceptor_vpc_id
}

data "aws_route_tables" "requestor" {
  vpc_id = var.requestor_vpc_id
}


resource "aws_vpc_peering_connection" "this" {
  vpc_id = var.requestor_vpc_id
  peer_vpc_id = var.acceptor_vpc_id

  auto_accept = var.auto_accept

  accepter {
    allow_remote_vpc_dns_resolution = var.acceptor_allow_remote_vpc_dns_resolution
  }

  requester {
    allow_remote_vpc_dns_resolution = var.requestor_allow_remote_vpc_dns_resolution
  }

  tags = local.tags
}


# Create routes from requestor to acceptor
resource "aws_route" "requestor" {
  count = length(data.aws_route_tables.requestor.ids)

  route_table_id = tolist(data.aws_route_tables.requestor.ids)[count.index]

  destination_cidr_block = data.aws_vpc.acceptor.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}

# Create routes from acceptor to requestor
resource "aws_route" "acceptor" {
  count = length(data.aws_route_tables.requestor.ids)

  route_table_id = tolist(data.aws_route_tables.acceptor.ids)[count.index]

  destination_cidr_block = data.aws_vpc.requestor.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}

