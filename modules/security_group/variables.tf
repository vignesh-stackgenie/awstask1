variable "vpc_id" {
  description = "The ID of the VPC."
  type        = string
}

variable "project_name" {
  description = "Name of the project."
  type        = string
}

variable "allowed_ip" {
  description = "IP address to allow SSH and HTTP access."
  type        = string
}
