resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "bhagya-state-table"
  billing_mode   = "PAY_PER_REQUEST"    #it is better than provisioned.
  hash_key       = "LockId"

  attribute {
    name = "LockId"
    type = "S"              #string
  }

  tags = {
    Name        = "bhagya-state-table"
    Environment = "production"
  }
}