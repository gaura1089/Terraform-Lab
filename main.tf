resource "aws_instance" "mach" {
  
   instance_type = "t2.micro"
   ami = "ami-0861f4e788f5069dd"
   key_name = "deployer-key"
  
  tags={
    Name = "linux-Client-Workstation"
  }

  
  user_data = <<EOF
#!/bin/bash
yum update -y
wget https://packages.chef.io/files/stable/chef-workstation/0.4.2/el/7/chef-workstation-0.4.2-1.el6.x86_64.rpm
yum install chef-workstation-0.4.2-1.el6.x86_64.rpm -y
yum install libxcrypt-compat -y
curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chef-workstation
EOF


}


# resource "aws_instance" "node" {
  
#    instance_type = "t2.micro"
#    ami = "ami-0861f4e788f5069dd"
#    key_name = "deployer-key"
  
#   tags={
#     Name = "linux-Node"
#   }

    
#   user_data = <<EOF
# #!/bin/bash
# yum update -y

# EOF
# }



# resource "aws_instance" "RedHat" {
  
#    instance_type = "t2.micro"
#    ami = "ami-0cf8ec67f4b13b491"
#    key_name = "deployer-key"
  
#   tags={
#     Name = "RedHat-linux"
#   }
  
# }


# resource "aws_instance" "Ubuntu" {
  
#    instance_type = "t2.micro"
#    ami = "ami-02d26659fd82cf299"
#    key_name = "deployer-key"
  
#   tags={
#     Name = "Ubuntu-linux"
#   }
  
# }






output "Workstation-ip" {
  value = aws_instance.mach.public_ip

}


# output "Node-ip" {
#   value = aws_instance.node.public_ip

# }



# output "public_ip1" {
#   value = aws_instance.RedHat.public_ip

# }

# output "public_ip2" {
#   value = aws_instance.Ubuntu.public_ip

# }