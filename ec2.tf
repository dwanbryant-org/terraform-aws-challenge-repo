resource "aws_kms_key" "ebs_key" {
  description             = "KMS key for EBS volume encryption"
  enable_key_rotation     = true
}

resource "aws_kms_alias" "ebs_key_alias" {
  name          = "alias/ebs_key"
  target_key_id = aws_kms_key.ebs_key.id
}

module "ec2_test" {
  source = "github.com/Coalfire-CF/terraform-aws-ec2"

  name = var.instance_name

  ami               = "ami-0468ac5f57c53fbad"
  ec2_instance_type = var.instance_type
  instance_count    = 1

  vpc_id = module.vpc_nfw.vpc_id
  subnet_ids = ["subnet-06b28c6b871aae790"]

  ec2_key_pair    = var.key_name
  ebs_kms_key_arn = aws_kms_key.ebs_key.arn
  ebs_optimized = false
  
  # Storage
  root_volume_size = 20

  # Security Group Rules
   ingress_rules = {
    "ssh" = {
      ip_protocol = "ssh"
      from_port   = "22"
      to_port     = "22"
      cidr_ipv4   = "0.0.0.0/0"
      description = "SSH"
    }
  }

  egress_rules = {
    "allow_all_egress" = {
      ip_protocol = "-1"
      from_port   = "0"
      to_port     = "0"
      cidr_ipv4   = "0.0.0.0/0"
      description = "Allow all egress"
    }
  }
  global_tags = {
    managed = "Terraform"
  }
    depends_on = [ aws_kms_key.ebs_key, aws_kms_alias.ebs_key_alias ]
}