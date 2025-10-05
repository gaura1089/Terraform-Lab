

resource "aws_instance" "Mac1" {

    ami= var.image_name
    instance_type = var.machine_type
    key_name = var.key-name
    vpc_security_group_ids = var.security-group
    region = var.location
 
    


   
    
    
    tags = {
      Name= var.tag_name
    }

}







output "instance_public_ip" {
  value = aws_instance.Mac1.public_ip
}


