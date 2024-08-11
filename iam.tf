resource "aws_iam_role" "asg_role" {
  name = "asg-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  inline_policy {
    name = "read-images-bucket"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = ["s3:GetObject"]
          Effect = "Allow"
          Resource = "${module.images_bucket.bucket_arn}/*"
        }
      ]
    })
  }
}

resource "aws_iam_role" "logs_role" {
  name = "logs-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  inline_policy {
    name = "write-logs-bucket"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = ["s3:PutObject"]
          Effect = "Allow"
          Resource = "${module.logs_bucket.bucket_arn}/*"
        }
      ]
    })
  }
}