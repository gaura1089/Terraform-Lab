resource "aws_instance" "mymach" {
   ami=  var.mac-img
   instance_type = var.mac-type
   vpc_security_group_ids = [var.sg-group.id]
   key_name = aws_key_pair.key.key_name
   region = var.location
   
   tags = {
    Name= var.Machin_name
   }


  
}

resource "aws_key_pair" "key" {
   provider = aws
    key_name  = var.acc-key
    public_key = file("${path.root}/id_rsa.pub")

}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
