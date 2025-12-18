resource "aws_instance" "nagios" {

   ami = "ami-0f9708d1cd2cfee41"
   instance_type = "t3.micro"
   key_name = "deployer-key"
  
  tags = {
    Name= "Nagios-Server ( Continues Monitoring tool)"

  }


provisioner "remote-exec" {
  inline = [
    
 # --- Base OS update & prerequisites ---
    "sudo dnf -y update",
    "sudo dnf -y install gcc make glibc glibc-common perl httpd php gd gd-devel openssl-devel wget unzip",

    # --- Nagios user/group setup ---
    "sudo id -u nagios >/dev/null 2>&1 || sudo useradd -r -M nagios",
    "sudo getent group nagcmd >/dev/null 2>&1 || sudo groupadd nagcmd",
    "sudo usermod -a -G nagcmd nagios",
    "sudo usermod -a -G nagcmd apache",

    # --- Nagios Core build & install (4.5.10) ---
    "cd /tmp",
    "wget https://github.com/NagiosEnterprises/nagioscore/releases/download/nagios-4.5.10/nagios-4.5.10.tar.gz",
    "tar xzf nagios-4.5.10.tar.gz",
    "cd nagios-4.5.10",
    "./configure --with-command-group=nagcmd",
    "make all",
    "sudo make install",
    "sudo make install-init",
    "sudo make install-commandmode",
    "sudo make install-config",
    "sudo make install-webconf",

    # --- Web UI credentials (replace the password!) ---
    "sudo htpasswd -bc /usr/local/nagios/etc/htpasswd.users nagiosadmin Gu@102831",

    # --- Nagios Plugins build & install (2.4.11) ---
    "cd /usr/local/src",
    "wget https://nagios-plugins.org/download/nagios-plugins-2.4.11.tar.gz",
    "tar xzf nagios-plugins-2.4.11.tar.gz",
    "cd nagios-plugins-2.4.11",
    "./configure --with-nagios-user=nagios --with-nagios-group=nagios",
    "make",
    "sudo make install",

    # --- Enable & start services ---
    "sudo systemctl enable --now httpd",
    "sudo systemctl enable --now nagios || sudo systemctl start nagios",

    # --- Optional: SELinux tweak if enforced ---
    "if command -v getenforce >/dev/null 2>&1; then sudo setsebool -P httpd_can_network_connect 1 || true; fi"
  ]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("${path.module}/id_rsa") # Update path if needed
    host        = aws_instance.nagios.public_ip
  }
}




}


  

output "Nagios-Public-ip" {

  value = aws_instance.nagios.public_ip
  
}








# sudo dnf install python3-pip -y
# python3 -m pip install --user ansible