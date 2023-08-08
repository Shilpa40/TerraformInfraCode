# Security Group for Public Load Balancer
module "loadbalancer_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "loadbalancer-sg"
  description = "Security group with HTTP port 80 open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id      = module.vpc.vpc_id

  # Ingress Rules & CIDR Block  
  ingress_rules       = ["http-80-tcp", "https-443-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  # Egress Rule - all-all open
  egress_rules = ["all-all"]

  tags = {
    "Name" = "loadbalancer_sg"
  }
}
