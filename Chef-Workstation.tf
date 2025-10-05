resource "aws_instance" "workstation" {
  
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



output "workstation_public_ip" {
  value = aws_instance.workstation.public_ip

}
