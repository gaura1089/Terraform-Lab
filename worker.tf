


resource "aws_instance" "worker-node" {

   ami = "ami-00ca570c1b6d79f36"

   instance_type = "t3.medium"
   key_name = "deployer-key"
   security_groups = [aws_security_group.k8s_sg2.name]
  
  tags = {
    Name= "worker-Server" }

provisioner "remote-exec" {
  inline = [
    # 1️⃣ Disable swap
    "sudo swapoff -a",
    "sudo sed -i '/swap/d' /etc/fstab",

    # 2️⃣ Load kernel modules
    "sudo modprobe overlay",
    "sudo modprobe br_netfilter",

    # 3️⃣ Enable sysctl params
    "sudo tee /etc/sysctl.d/k8s.conf <<EOF\nnet.bridge.bridge-nf-call-iptables = 1\nnet.ipv4.ip_forward = 1\nnet.bridge.bridge-nf-call-ip6tables = 1\nEOF",
    "sudo sysctl --system",

    # 4️⃣ Install containerd
    "sudo dnf install -y containerd",
    "sudo mkdir -p /etc/containerd",
    "containerd config default | sudo tee /etc/containerd/config.toml",
    "sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml",
    "sudo systemctl daemon-reexec",
    "sudo systemctl enable --now containerd",
    "sudo systemctl start --now containerd",

    # 5️⃣ Add Kubernetes repo
    "sudo tee /etc/yum.repos.d/kubernetes.repo <<EOF\n[kubernetes]\nname=Kubernetes\nbaseurl=https://pkgs.k8s.io/core:/stable:/v1.29/rpm/\nenabled=1\ngpgcheck=1\ngpgkey=https://pkgs.k8s.io/core:/stable:/v1.29/rpm/repodata/repomd.xml.key\nEOF",

    # 6️⃣ Install Kubernetes components
    "sudo dnf install -y kubeadm kubelet kubectl",
    "sudo systemctl enable --now kubelet",
    "sudo systemctl start --now kubelet",

  ]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("${path.module}/id_rsa")
    host        = aws_instance.worker-node.public_ip
  }
}



 
}

output "worker-Public-ip" {

  value = aws_instance.worker-node.public_ip
  
}






# 1) Security Group for SSH and Jenkins
resource "aws_security_group" "k8s_sg2" {
  name        = "k8s-sg2"
  description = "Allow SSH and Jenkins (8080)"
#   vpc_id      = data.aws_vpc.default.id

  

  ingress {
     description = "Allow all INbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "worker-node-sg"
  }





}

# # Get default VPC (simpler for demo)
# data "aws_vpc" "default" {
#   default = true
# }
