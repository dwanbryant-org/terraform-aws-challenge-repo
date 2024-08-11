module "images_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.1.2"

  bucket = "bryant-coalfire-images"

  lifecycle_rule = {
    id      = "archive-memes"
    enabled = true

    filter {
      prefix = "Memes/"
    }

    transition {
      days          = 90
      storage_class = "GLACIER"
    }
  }

  tags = {
    Name        = "images"
    Environment = "coalfire"
  }
}

module "logs_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.1.2"

  bucket = "bryant-coalfire-logs"

  lifecycle_rule = {
    id      = "archive-active"
    enabled = true

    filter {
      prefix = "Active/"
    }

    transition {
      days          = 90
      storage_class = "GLACIER"
    }

    filter {
      prefix = "Inctive/"
    }

    expiration {
        days = 90
    }
  }


  tags = {
    Name        = "logs"
    Environment = "coalfire"
  }
}