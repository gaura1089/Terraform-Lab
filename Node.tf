resource "aws_instance" "linux-node" {
  
   instance_type = "t2.micro"
   ami = "ami-0861f4e788f5069dd"
   key_name = "deployer-key"
  
  tags={
    Name = "linux-Node"
  }

    
  user_data = <<EOF
#!/bin/bash
yum update -y

EOF
}

output "node-ip" {
  value = aws_instance.linux-node.public_ip

}
