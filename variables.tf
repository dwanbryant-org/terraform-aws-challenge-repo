variable "aws_region" {
  description = "The AWS region to deploy the VPC in."
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "availability_zones" {
  description = "A list of availability zones in the region."
  type        = list(string)
}

variable "public_subnets" {
  description = "A list of CIDR blocks for the public subnets."
  type        = list(string)
}

variable "private_subnets" {
  description = "A list of CIDR blocks for the private subnets."
  type        = list(string)
}

variable "environment" {
  description = "The environment for the VPC"
  type        = string
}