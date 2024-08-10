terraform {
  backend "s3" {
    bucket         = "bryant-terraform-tfstate"
    key            = "terraform.tfstate"
    region         = var.aws_region
    dynamodb_table = "bryant-terraform-tfstate-db"
  }
}