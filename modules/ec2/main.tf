resource "aws_spot_instance_request" "web_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  spot_price    = var.spot_price

  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  iam_instance_profile   = var.iam_instance_profile

  user_data = var.user_data_script

  wait_for_fulfillment = true

  tags = {
    Name = var.instance_name
  }
}
