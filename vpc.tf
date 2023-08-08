provider "aws" {
  region = var.region
}

# Create VPC Terraform Module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"

  name = "Test-vpc1"
  cidr = var.vpc_cidr_block

  azs             = ["us-east-1a", "us-east-1b"]
  public_subnets  = var.vpc_public_subnets
  private_subnets = var.vpc_private_subnets

  # NAT Gateways - Outbound Communication
  enable_nat_gateway = true
  single_nat_gateway = true

  # VPC DNS Parameters
  enable_dns_hostnames = true
  enable_dns_support   = true

  public_subnet_tags = {
    Type = "public-subnets"
  }

  private_subnet_tags = {
    Type = "private-subnets"
  }

  #reuse_nat_ips = true # <= Skip creation of EIPs for the NAT Gateways
  #external_nat_ip_ids = "${aws_eip.nat.*.id}"   # <= IPs specified here as input to the module

  # Instances launched into the Public subnet should be assigned a public IP address.
  map_public_ip_on_launch = true

  vpc_tags = {
    Name = "Test-vpc1"
  }
}

/*resource "aws_eip" "nat" {
  count = 1
  vpc = true
} */

