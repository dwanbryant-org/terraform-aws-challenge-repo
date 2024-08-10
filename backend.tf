terraform {
  backend "s3" {
    bucket         = "bryant-terraform-tfstate"
    key            = "terraform.tfstate"
    region         =  "us-east-1"
    dynamodb_table = "bryant-terraform-tfstate-db"
  }
}