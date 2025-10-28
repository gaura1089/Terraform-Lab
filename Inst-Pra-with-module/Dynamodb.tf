
# resource "aws_dynamodb_table" "tf_lock" {
#   provider     = aws.Mumbai
#   name         = "terraform-lock-table"
#   billing_mode = "PAY_PER_REQUEST"
#   hash_key     = "LockID"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }

#   tags = {
#     Name = "Terraform Lock Table"
#   }
# }
