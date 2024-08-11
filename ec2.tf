data "aws_ami" "redhat_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["RHEL--HVM-"]
  }

  owners = ["309956199498"]
}

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

  ami               = data.redhat_ami.ami.id
  ec2_instance_type = var.instance_size
  instance_count    = 1

  vpc_id = module.vpc_nfw.id
  subnet_ids = [module.vpc_nfw.subnet.private_subnets[1].id]

  ec2_key_pair    = var.key_name
  ebs_kms_key_arn = aws_kms_key.ebs_key.arn
  
  # Storage
  root_volume_size = 20

  # Security Group Rules
   ingress_rules = {
    "rdp" = {
      ip_protocol = "tcp"
      from_port   = "22"
      to_port     = "22"
      cidr   = ["0.0.0.0/0"]
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

    depends_on = [ aws_kms_key.ebs_key, aws_kms_alias.ebs_key_alias ]
}