


module "linux-mach" {
  source       =  "./module/mod1"
  image_name   = "ami-0d79a5965912eecc9"
  machine_type ="t2.micro"
  tag_name     ="Linux1-Mumbai"
  # pub-key      =  file("${path.module}/id_rsa.pub")
  key_name     = "ins-key"
  security-group  = [aws_security_group.sg-mumbai.id] 
  location =  "ap-south-1" # Mumbai Region 
}


module "linux-mach-2" {
   source       =  "./module/mod1"
  image_name   = "ami-00ca32bbc84273381"
  machine_type = "t2.micro"
  tag_name     = "Linux2-US East"
  # pub-key      =  file("${path.module}/id_rsa.pub")
  key_name     =  "mykey"
  security-group = [aws_security_group.sg_virginia.id] 
  location = "us-east-1" #  N.Varinia 


  
}













# module "Win-mach" {

#   source = "./module/mod1"

#   image_name= "ami-0d0ad8bb301edb745"
#   machine_type = "t2.micro"
#   tag_name= "Linux2"


# }

terraform {
  backend "s3" {
    bucket = "terraform.tfstatebucket"
    key    = "terraform.tfstate"
    region = "ap-south-1"
    # dynamodb_table = "terraform-locks"
    # encrypt        = true

  }
}

output "pub-key" {

  value = file("${path.module}/id_rsa.pub")

}


output "linux_instance_public_ip" {
  value = module.linux-mach.instance_public_ip
}
