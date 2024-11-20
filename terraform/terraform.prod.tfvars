# terraform.prod.tfvars

environment           = "prod"
aws_profile           = "default"  # Change to your AWS CLI profile if different
ami_id                = "ami-0abcdef1234567890"  # Replace with a valid AMI ID for your region
ssh_key_name          = "node1"  # Replace with your actual key pair name
docker_image          = "your_dockerhub_username/yourapp:latest"
ec2_tag_name          = "prod-django-app-instance"
instance_role_name    = "prod-ec2-instance-role"
instance_profile_name = "prod-ec2-instance-profile"
allowed_ip            = "0.0.0.0/0"  # Restrict in production as needed
