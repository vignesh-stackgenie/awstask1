# Data source to get the list of availability zones in the current region
data "aws_availability_zones" "available" {
  state = "available"
}

# Data source to find the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# VPC Module
module "vpc" {
  source = "./modules/vpc"

  aws_region           = var.aws_region
  project_name         = var.project_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = data.aws_availability_zones.available.names
}

# Security Group Module
module "security_group" {
  source = "./modules/security_group"

  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  allowed_ip   = var.allowed_ip
}

# IAM Module for EC2 Instance Profile
module "iam" {
  source = "./modules/iam"

  project_name = var.project_name
}

# EC2 Instance Module for Apache
module "apache_ec2" {
  source = "./modules/ec2"

  instance_name          = "${var.project_name}-apache-instance"
  ami_id                 = data.aws_ami.amazon_linux_2.id
  instance_type          = var.instance_type
  subnet_id              = module.vpc.public_subnet_ids[0]
  vpc_security_group_ids = [module.security_group.public_sg_id]
  iam_instance_profile   = module.iam.instance_profile_name
  user_data_script       = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Deployed Apache via Terraform</h1>" > /var/www/html/index.html
              EOF
}

# EC2 Instance Module for Nginx
module "nginx_ec2" {
  source = "./modules/ec2"

  instance_name          = "${var.project_name}-nginx-instance"
  ami_id                 = data.aws_ami.amazon_linux_2.id
  instance_type          = var.instance_type
  subnet_id              = module.vpc.private_subnet_ids[0]
  vpc_security_group_ids = [module.security_group.private_sg_id]
  iam_instance_profile   = module.iam.instance_profile_name
  user_data_script       = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install nginx1 -y
              systemctl start nginx
              systemctl enable nginx
              echo "<h1>Deployed Nginx via Terraform in a private subnet</h1>" > /usr/share/nginx/html/index.html
              EOF
}

