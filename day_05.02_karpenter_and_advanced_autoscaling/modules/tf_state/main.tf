resource "aws_s3_bucket" "s3_tf_state" {
  bucket = var.s3_bucket_name

  tags = {
    Name        = var.s3_bucket_name
    Environment = var.environment
  }
}

resource "aws_s3_bucket_versioning" "s3_tf_state_versioning" {
  bucket = aws_s3_bucket.s3_tf_state.id

  versioning_configuration {
    status = "Enabled"
  }
}