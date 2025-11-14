


resource "aws_instance" "jenkins" {

   ami = "ami-03695d52f0d883f65"
   instance_type = "t3.micro"
   key_name = "deployer-key"
   security_groups = [aws_security_group.jenkins_sg.name]
  
  tags = {
    Name= "Jenkins-Server"

  }
 


provisioner "remote-exec" {
  inline = [
    "sudo yum update -y",
    "sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo",
    "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key",
    "sudo yum install java-21-amazon-corretto -y",
    "sudo yum install jenkins -y",
    "sudo systemctl enable jenkins",
    "sudo systemctl start jenkins",
    "sudo systemctl is-active jenkins"
  ]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("${path.module}/id_rsa") # must match 'deployer-key' key pair
    host        = aws_instance.jenkins.public_ip
  }
}
 
}

output "Jenkins-Public-ip" {

  value = aws_instance.jenkins.public_ip
  
}






# 1) Security Group for SSH and Jenkins
resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-sg"
  description = "Allow SSH and Jenkins (8080)"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # tighten for security if needed
  }

  ingress {
    description = "Jenkins UI"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # restrict to office IPs if possible
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jenkins-sg"
  }
}

# Get default VPC (simpler for demo)
data "aws_vpc" "default" {
  default = true
}
