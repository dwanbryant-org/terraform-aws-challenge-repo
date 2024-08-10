module "account-setup" {
  source = "github.com/Coalfire-CF/terraform-aws-account-setup?ref=v0.0.20"

  aws_region         = var.aws_region
  default_aws_region = var.aws_region

  application_account_numbers = [var.account_number]
  account_number              = var.account_number

  resource_prefix         = var.resource_prefix

  ### KMS ###
  additional_kms_keys = [
    {
      name   = "nfw"
      policy = "${data.aws_iam_policy_document.default_key_policy.json}"
    }
  ]
}