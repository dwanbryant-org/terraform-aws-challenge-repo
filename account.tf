# module "account-setup" {
#   source = "github.com/Coalfire-CF/terraform-aws-account-setup?ref=v0.0.20"

#   aws_region         = var.aws_region
#   default_aws_region = var.aws_region

#   application_account_numbers = [var.account_number]
#   account_number              = var.account_number

#   resource_prefix         = var.resource_prefix

#   ### KMS ###
#   additional_kms_keys = [
#     {
#       name   = "nfw"
#       policy = "${data.aws_iam_policy_document.default_key_policy.json}"
#     }
#   ]
# }

# data "aws_iam_policy_document" "default_key_policy" {
#   statement {
#     actions = [
#       "kms:Encrypt",
#       "kms:Decrypt",
#       "kms:ReEncrypt*",
#       "kms:GenerateDataKey*",
#       "kms:DescribeKey",
#     ]

#     principals {
#       type        = "AWS"
#       identifiers = [
#         # Add the ARN of the IAM role, user, or service that should be allowed to use the key
#         "arn:aws:iam::${var.account_number}:role/cicd",
#       ]
#     }

#     resources = [
#       "*"
#     ]
#   }

#   statement {
#     actions = [
#       "kms:Create*",
#       "kms:Describe*",
#       "kms:Enable*",
#       "kms:List*",
#       "kms:Put*",
#       "kms:Update*",
#       "kms:Revoke*",
#       "kms:Disable*",
#       "kms:Get*",
#       "kms:Delete*",
#       "kms:TagResource",
#       "kms:UntagResource",
#       "kms:ScheduleKeyDeletion",
#       "kms:CancelKeyDeletion",
#     ]

#     principals {
#       type        = "AWS"
#       identifiers = [
#         "arn:aws:iam::${var.account_number}:root",
#       ]
#     }

#     resources = [
#       "*"
#     ]
#   }
# }