output "apache_public_ip" {
  description = "Public IP address of the Apache web server."
  value       = module.apache_ec2.public_ip
}

output "apache_instance_id" {
  description = "Instance ID of the Apache EC2 instance."
  value       = module.apache_ec2.instance_id
}

output "nginx_instance_id" {
  description = "Instance ID of the Nginx EC2 instance in the private subnet."
  value       = module.nginx_ec2.instance_id
}
