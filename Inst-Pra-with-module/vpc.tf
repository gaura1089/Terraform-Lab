data "aws_vpc" "default" {
  provider = aws.Mumbai
  default  = true
}

data "aws_vpc" "default1" {
  provider = aws.US
  default  = true
}
