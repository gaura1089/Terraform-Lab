# resource "aws_instance" "linux-node1" {
  
#    instance_type = "t2.micro"
#    ami = "ami-0861f4e788f5069dd"
#    key_name = "deployer-key"
  
#   tags={
#     Name = "linux-Node-1"
#   }

    
#   user_data = <<EOF
# #!/bin/bash
# yum update -y

# EOF
# }


# resource "aws_instance" "linux-node2" {
  
#    instance_type = "t2.micro"
#    ami = "ami-0861f4e788f5069dd"
#    key_name = "deployer-key"
  
#   tags={
#     Name = "linux-Node-2"
#   }

    
#   user_data = <<EOF
# #!/bin/bash
# yum update -y

# EOF
# }


variable "instances" {
  default = {
    # "linux-node1" = "linux-Node-1"
    # "linux-node2" = "linux-Node-2"
    # "linux-node3" = "linux-Node-3"
    # "linux-node4" = "linux-Node-4"
    "linux-node5" = "linux-Node-5"
  }
}

resource "aws_instance" "linux_nodes" {
  for_each      = var.instances
  ami           = "ami-0861f4e788f5069dd"
  instance_type = "t2.micro"
  key_name      = "deployer-key"

  tags = {
    Name = each.value
  }

  user_data = <<EOF
#!/bin/bash
yum update -y
EOF
}

output "public_ips" {
  value = {
    for instance_key, instance in aws_instance.linux_nodes :
    instance_key => instance.public_ip
  }
}




