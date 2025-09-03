# terraform for creating AWS resources

'''
Build A vpc with public and private subnet

deploy a nginx webserver on private subnet and access via public IP

deploy a apache webserver in public subnet

The security group only allows incoming traffic from a specified IP that should mention dynamically.

Create an IAM role with minimal Session Manager permissions to access these instance

all instances should be in spot instance and instance type t3.small
