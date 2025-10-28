# resource "aws_instance" "mymach" {
#    ami= "ami-0861f4e788f5069dd"
#    instance_type = "t2.micro"
#    provider = aws.Mumbai
#    vpc_security_group_ids = [aws_security_group.SG1.id]
#    key_name = "Mum-key"


#   tags={
#   Name= "Linux-Mum"
#   }


  
# }


module "module1"{
  source =  "./module/mod1"
  providers =  {aws=aws.Mumbai
  }
   mac-img = "ami-0861f4e788f5069dd"
   mac-type = "t2.micro"
   acc-key = "Mum-key"
   sg-group = aws_security_group.SG1
   Machin_name=  "Linux-Mumbai"
   location =  "ap-south-1"

}


module "module2" {
  source = "./module/mod1"
  providers = { aws= aws.US 
    
  }
 
   mac-img =  "ami-00ca32bbc84273381"
   mac-type =   "t2.micro"
   acc-key =  "US-key"
   sg-group = aws_security_group.SG2
   Machin_name= "Linux-US"
   location =  "us-east-1"


}







# resource "aws_instance" "mymach-1" {
#    ami= "ami-00ca32bbc84273381"
#    instance_type = "t2.micro"
#    provider = aws.US
#    vpc_security_group_ids = [aws_security_group.SG2.id]
#    key_name = "US-key"
   


#   tags={
#   Name= "Linux-US"
#   }


  
