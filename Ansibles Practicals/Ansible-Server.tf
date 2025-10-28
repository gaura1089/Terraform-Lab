# resource "aws_instance" "linux" {

#    ami = "ami-0f9708d1cd2cfee41"
#    instance_type = "t2.micro"
#    key_name = "Ansible"
  
#   tags = {
#     Name= "Ansible-Server"

#   }

# user_data = <<-EOF
# #!/bin/bash
# # Update system
# yum update -y || dnf update -y

# # Install Ansible
# dnf install -y ansible

# # Switch to ec2-user's home
# cd /home/ec2-user

# # Generate SSH key (no passphrase)
# ssh-keygen -t rsa -b 4096 -f /home/ec2-user/.ssh/id_rsa -q -N ""

# # Create Ansible project folder
# mkdir -p ansible_project
# cd ansible_project

# # Create inventory file
# echo "[webservers]
# node1 ansible_host=172.31.44.16 ansible_user=ec2-user" > myhosts.ini

# # Create ansible.cfg file
# echo "[defaults]
# inventory = ./myhosts.ini
# host_key_checking = False" > ansible.cfg

# # Set ownership to ec2-user
# chown -R ec2-user:ec2-user /home/ec2-user/.ssh /home/ec2-user/ansible_project
# EOF

  

  
# }

# output "Ansible-Public-ip" {

#   value = aws_instance.linux.public_ip
  
# }








# # sudo dnf install python3-pip -y
# # python3 -m pip install --user ansible