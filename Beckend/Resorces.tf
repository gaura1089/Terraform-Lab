







terraform {
  # backend "s3" {
  #   bucket = "terraform.tfstatebucket"
  #   key    = "terraaform.tfstate"
  #   region = "ap-south-1"
  # }
}









resource "aws_instance" "my-aws_instance" {

    ami= "ami-0d0ad8bb301edb745"
    instance_type = "t2.micro"
  
}