# EC2 Instances that will be created in VPC Private Subnets for App1
module "ec2_private_app1" {
  depends_on = [module.vpc] # VERY VERY IMPORTANT else userdata webserver provisioning will fail
  source     = "terraform-aws-modules/ec2-instance/aws"
  version    = "2.17.0"
  # insert the 10 required variables here
  name          = "app1"
  ami           = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  key_name      = var.instance_keypair
  #monitoring             = true
  vpc_security_group_ids = [module.private_sg.security_group_id]
  #subnet_id              = module.vpc.public_subnets[0]  
  subnet_ids = [
    module.vpc.private_subnets[0],
    module.vpc.private_subnets[1]
  ]
  instance_count = 2
  user_data      = file("app1.sh")
  tags = {
    Name = "Instance-app1"
  }
}


