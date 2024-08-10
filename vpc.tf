provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source  = "github.com/Coalfire-CF/terraform-aws-vpc-nfw"
  version = "2.0.7"

  vpc_cidr = var.vpc_cidr

  azs             = var.availability_zones
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  tags = {
    Environment = var.environment
    managed     = "terraform"
  }
}