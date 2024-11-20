output "app_instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.app_instance.public_ip
}

output "app_instance_public_dns" {
  description = "Public DNS of the EC2 instance"
  value       = aws_instance.app_instance.public_dns
}

output "ec2_instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app_instance.id
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main_vpc.id
}

# output "ec2_public_ip" {
#   description = "The public IP address of the EC2 instance"
#   value       = aws_instance.webserver.public_ip
# }