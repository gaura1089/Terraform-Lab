

# resource "aws_key_pair" "key-US" {
#   provider = aws.US
#   key_name   = "US-key"
#   public_key = file("${path.module}/id_rsa.pub")
# }