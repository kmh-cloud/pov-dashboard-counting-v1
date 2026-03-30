############################################
# Project & Environment Variables
############################################

variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, stage, prod, hellocloud)"
  type        = string
}

############################################
# Provider Variables
############################################

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "aws_profile" {
  description = "AWS CLI profile for authentication"
  type        = string
}

############################################
# Network (VPC) Variables
############################################

variable "vpc_cidr" {
  description = "CIDR block for the VPC (kmh_vpc)"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone for subnets"
  type        = string
}

############################################
# Security Variables
############################################

variable "my_ip" {
  description = "Trusted IP address for SSH access (CIDR format)"
  type        = list(string)
}

############################################
# EC2 / Compute Variables
############################################

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

# variable "prefix" {
#   description = "Prefix for resource naming (e.g., project name or environment)"
#   type        = string
# }