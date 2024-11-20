variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "The AWS CLI profile to use"
  type        = string
  default     = "default"
}

variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "ssh_key_name" {
  description = "SSH key pair name for EC2 instance access"
  type        = string
}

variable "allowed_ip" {
  description = "IP address allowed to access the application"
  type        = string
  default     = "0.0.0.0/0"
}

variable "docker_image" {
  description = "Docker image to deploy"
  type        = string
}

variable "ec2_tag_name" {
  description = "Name tag for the EC2 instance"
  type        = string
}

variable "instance_role_name" {
  description = "Name for the IAM role attached to EC2"
  type        = string
}

variable "instance_profile_name" {
  description = "Name for the IAM instance profile"
  type        = string
}

variable "ssh_allowed_ip" {
  description = "IP addresses allowed to SSH into the EC2 instance"
  type        = string
  default     = "0.0.0.0/0"  # Replace with your public IP for security
}