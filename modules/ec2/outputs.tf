# modules/ec2/outputs.tf

output "instance_id" {
  description = "The ID of the EC2 instance that was launched to fulfill the spot request."
  value       = aws_spot_instance_request.web_server.spot_instance_id
}

output "public_ip" {
  description = "The public IP address assigned to the EC2 instance."
  value       = aws_spot_instance_request.web_server.public_ip
}

output "private_ip" {
  description = "The private IP address assigned to the EC2 instance."
  value       = aws_spot_instance_request.web_server.private_ip
}
