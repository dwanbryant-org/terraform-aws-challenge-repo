provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_kms_key" "cloudwatch_key" {
  description             = "KMS key for CloudWatch log group encryption"
  enable_key_rotation     = true

  policy = data.aws_iam_policy_document.default_key_policy.json

  tags = {
    Name = "cloudwatch-key"
  }
}

data "aws_iam_policy_document" "default_key_policy" {
  statement {
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
    ]

    principals {
      type        = "AWS"
      identifiers = [
        # Add the ARN of the IAM role, user, or service that should be allowed to use the key
        "arn:aws:iam::${var.account_number}:role/cicd",
      ]
    }

    resources = [
      "*"
    ]
  }
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

  public_subnets = local.public_subnets
  private_subnets =local.private_subnets
  private_subnet_tags = {
    "0" = "Private"
    "1" = "Private"
  }

  public_subnet_suffix = "public"

  enable_nat_gateway     = false
  single_nat_gateway     = false
  one_nat_gateway_per_az = false
  enable_vpn_gateway     = false
  enable_dns_hostnames   = true

  flow_log_destination_type = "cloud-watch-logs"
  cloudwatch_log_group_retention_in_days = 30
  cloudwatch_log_group_kms_key_id        = aws_kms_key.cloudwatch_key.arn

  tags = {
    Owner       = var.resource_prefix
    Environment = "vpc"
    createdBy   = "terraform"
  }

#   depends_on = [ module.account-setup ]
}