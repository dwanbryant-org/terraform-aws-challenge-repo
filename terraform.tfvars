aws_region         = "us-east-1"
vpc_cidr           = "10.1.0.0/16"
availability_zones = ["us-east-1a", "us-east-1b"]
public_subnets     = ["10.1.0.0/24", "10.1.1.0/24"]
private_subnets    = ["10.1.2.0/24", "10.1.3.0/24"]
environment        = "dev"