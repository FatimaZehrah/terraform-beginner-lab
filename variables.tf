variable "aws_region" {
  description = "AWS region for resources"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "vpc_name" {
  description = "Name tag for VPC"
  type        = string
}

variable "subnet_name" {
  description = "Name tag for subnet"
  type        = string
}

variable "instance_name" {
  description = "Name tag for EC2 instance"
  type        = string
}