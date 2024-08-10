provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc_nfw" {
  source =  "github.com/Coalfire-CF/terraform-aws-vpc-nfw"

  name = "${var.resource_prefix}-vpc"

  delete_protection = false

  cidr = var.vpc_cidr

  azs = [
    data.aws_availability_zones.available.names[0], 
    data.aws_availability_zones.available.names[1]
  ]

  public_subnets = {
    "subnet1" = var.public_subnet_a_cidr,
    "subnet2" = var.public_subnet_b_cidr
  }

  private_subnets = {
    "subnet3" = var.private_subnet_a_cidr,
    "subnet4" = var.private_subnet_b_cidr
  }

  public_subnet_suffix = "public"

  enable_nat_gateway     = false
  single_nat_gateway     = false
  one_nat_gateway_per_az = false
  enable_vpn_gateway     = false
  enable_dns_hostnames   = true

  flow_log_destination_type = "cloud-watch-logs"
  cloudwatch_log_group_retention_in_days = 30
  cloudwatch_log_group_kms_key_id        = data.terraform_remote_state.day0.outputs.cloudwatch_kms_key_arn

  tags = {
    Owner       = var.resource_prefix
    Environment = "vpc"
    createdBy   = "terraform"
  }

  depends_on = [ module.account-setup ]
}