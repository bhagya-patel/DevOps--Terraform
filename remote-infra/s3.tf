resource "aws_s3_bucket" "remote_s3" {
  bucket = "bhagya-tf-state-bucket"

  tags = {
    Name        = "bhagya-tf-state-bucket"
    
  }
}
