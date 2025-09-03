output "ec2_instance_profile_arn" {
  description = "The ARN of the EC2 instance profile created."
  value       = aws_iam_instance_profile.ec2_profile.arn
}

output "instance_profile_name" {
  description = "The name of the IAM instance profile, to be used in EC2 instance configurations."
  value       = aws_iam_instance_profile.ec2_profile.name
}
