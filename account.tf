module "account-setup" {
  source = "github.com/Coalfire-CF/terraform-aws-account-setup?ref=v0.0.20"

  aws_region         = var.aws_region
  default_aws_region = var.aws_region

  application_account_numbers = [var.account_number]
  account_number              = var.account_number

  resource_prefix         = var.resource_prefix
  
  ### Cloudtrail ###
  create_cloudtrail                      = true
  is_organization                        = true
  organization_id                        = var.organization_id
  cloudwatch_log_group_retention_in_days = 30

  ### KMS ###
  additional_kms_keys = [
    {
      name   = "nfw"
      policy = "${data.aws_iam_policy_document.default_key_policy.json}"
    }
  ]

  ### Packer ###
  create_packer_iam = false # Packer AMIs will be built and kept on this account and shared with other accounts (share accounts is provided to Packer as a variable at build time)

  ### Terraform ###
  create_security_core = true # Terraform state will be kept on this account
}