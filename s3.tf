module "images_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.1.2"

  bucket = "images"

  lifecycle_rule = [
    {
      id      = "archive-memes"
      enabled = true

      filter = {
        prefix = "Memes/"
      }

      transitions = [
        {
          days          = 90
          storage_class = "GLACIER"
        }
      ]
    }
  ]

  tags = {
    Name        = "images"
    Environment = "coalfire"
  }
}

module "logs_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.1.2"

  bucket = "logs"

  lifecycle_rule = [
    {
      id      = "archive-active"
      enabled = true

      filter = {
        prefix = "Active/"
      }

      transitions = [
        {
          days          = 90
          storage_class = "GLACIER"
        }
      ]
    },
    {
      id      = "delete-inactive"
      enabled = true

      filter = {
        prefix = "Inactive/"
      }

      expiration = {
        days = 90
      }
    }
  ]

  tags = {
    Name        = "logs"
    Environment = "coalfire"
  }
}