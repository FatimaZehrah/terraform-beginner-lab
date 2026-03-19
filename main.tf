provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "lab_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name        = var.vpc_name
    Environment = "Lab"
    Owner       = "Fatima"
    Project     = "Terraform Beginner Lab"
  }
}

resource "aws_subnet" "lab_subnet" {
  vpc_id     = aws_vpc.lab_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name        = var.subnet_name
    Environment = "Lab"
    Owner       = "Fatima"
    Project     = "Terraform Beginner Lab"
  }
}

resource "aws_instance" "lab_ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.lab_subnet.id

  tags = {
    Name        = var.instance_name
    Environment = "Lab"
    Owner       = "Fatima"
    Project     = "Terraform Beginner Lab"
  }
}