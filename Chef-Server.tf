resource "aws_instance" "Chef" {
  ami           = "ami-02d26659fd82cf299" # Ubuntu 22.04 LTS (update as per region)
  instance_type = "t2.medium"
  key_name      = "deployer-key"

  tags = {
    Name = "linux-Chef-Server"
  }

  user_data = <<EOF
#!/bin/bash
apt update -y
apt install -y wget
wget https://packages.chef.io/files/stable/chef-server/15.3.2/ubuntu/22.04/chef-server-core_15.3.2-1_amd64.deb
dpkg -i chef-server-core_15.3.2-1_amd64.deb
chef-server-ctl reconfigure
chef-server-ctl status
chef-server-ctl install chef-manage
chef-server-ctl reconfigure
chef-manage-ctl reconfigure
chef-server-ctl user-create gaurav Gaurav Upadhayay gaurav@dropmail.live 'Gu@102831' --filename /home/ubuntu/gaurav.pem
chef-server-ctl org-create coforge 'Coforge Ltd.' --association_user gaurav --filename /home/ubuntu/coforge-validator.pem
chef-server-ctl reindex --all-orgs
EOF
}



output "chef_public_ip" {
  value = aws_instance.Chef.public_ip

}