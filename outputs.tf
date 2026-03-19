output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.lab_vpc.id
}

output "subnet_id" {
  description = "ID of the created subnet"
  value       = aws_subnet.lab_subnet.id
}

output "instance_id" {
  description = "ID of the created EC2 instance"
  value       = aws_instance.lab_ec2.id
}

output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.lab_ec2.public_ip
}