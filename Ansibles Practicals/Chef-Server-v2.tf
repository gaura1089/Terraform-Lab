resource "aws_instance" "Chef-v2" {
  ami           = "ami-02d26659fd82cf299"
  instance_type = "t2.medium"
  key_name      = "deployer-key"

  tags = {
    Name = "Ubuntu-Chef-Server-v2"
  }

provisioner "remote-exec" {
  inline = [
    "sudo apt update -y",
    "sudo apt install -y wget",
    "wget https://packages.chef.io/files/stable/chef-server/15.3.2/ubuntu/22.04/chef-server-core_15.3.2-1_amd64.deb",
    "sudo CHEF_LICENSE=accept dpkg -i chef-server-core_15.3.2-1_amd64.deb",
    "sudo CHEF_LICENSE=accept chef-server-ctl reconfigure",
    "sudo CHEF_LICENSE=accept chef-server-ctl install chef-manage",
    "sudo CHEF_LICENSE=accept chef-server-ctl reconfigure",
    "sudo CHEF_LICENSE=accept chef-manage-ctl reconfigure",
    "sudo mkdir -p /home/ubuntu",
    "sudo CHEF_LICENSE=accept chef-server-ctl user-create gaurav Gaurav Upadhayay gaurav@dropmail.live 'Gu@102831' --filename /home/ubuntu/gaurav.pem",
    "sudo CHEF_LICENSE=accept chef-server-ctl org-create dropmail 'Dropmail pvt. Ltd.' --association_user gaurav --filename /home/ubuntu/dropmail-validator.pem",
    "sudo CHEF_LICENSE=accept chef-server-ctl reindex --all-orgs"
  ]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("${path.module}/id_rsa") # Update path if needed
    host        = aws_instance.Chef-v2.public_ip
  }
}






}

output "chef_public_ip-v2" {
  value = aws_instance.Chef-v2.public_ip
}