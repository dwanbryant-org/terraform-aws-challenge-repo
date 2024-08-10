variable "aws_region" {
  description = "The AWS region to create resources in."
  type        = string
  default     = "us-east-1"
}

variable "account_number" {
    description = "Account number"
    type = string
}


variable "resource_prefix" {
  description = "Prefix for resource names."
  type        = string
  default     = "coalfire"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.1.0.0/16"
}

# variable "public_subnet_a_cidr" {
#   description = "The CIDR block for the first public subnet."
#   type        = string
#   default     = "10.1.0.0/24"
# }

# variable "public_subnet_b_cidr" {
#   description = "The CIDR block for the second public subnet."
#   type        = string
#   default     = "10.1.1.0/24"
# }

# variable "private_subnet_a_cidr" {
#   description = "The CIDR block for the first private subnet."
#   type        = string
#   default     = "10.1.2.0/24"
# }

# variable "private_subnet_b_cidr" {
#   description = "The CIDR block for the second private subnet."
#   type        = string
#   default     = "10.1.3.0/24"
# }