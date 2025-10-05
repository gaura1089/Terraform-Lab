data "aws_vpc" "default_mumbai" {
  provider = aws.mumbai
  default  = true
 
}

data "aws_vpc" "default_virginia" {
  provider = aws.virginia
  default  = true
}
