variable "instance_name" {
  description = "The specific name for this instance (e.g., project-apache-instance)."
  type        = string
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance."
  type        = string
}

variable "instance_type" {
  description = "The type of the EC2 instance (e.g., t3a.small)."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet to launch the instance in."
  type        = string
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with the instance."
  type        = list(string)
}

variable "iam_instance_profile" {
  description = "The name of the IAM instance profile to attach to the instance."
  type        = string
}

variable "user_data_script" {
  description = "The user data script to run on instance startup."
  type        = string
  default     = null
}

variable "spot_price" {
  description = "The maximum price to pay for a Spot Instance."
  type        = string
  default     = "0.02" 
}
