#----------------------------------------------------------
#  Provision EC2 instances with Jenkins  
#
#  Date: 23.12.22 6.40 P.M 
#
#  Made by Mustofa Kodirov
#----------------------------------------------------------

# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 3.74"
#     }
#   }
# }

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_default_vpc" "default" {} # This need to be added since AWS Provider v4.29+ to get VPC id

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.example.public_key_openssh

  provisioner "local-exec" { # Create "myKey.pem" to your computer!!
    command = "echo '${tls_private_key.example.private_key_pem}' > $(date +%d-%m).pem && chmod 400 $(date +%d-%m).pem"
  }
}


resource "aws_instance" "jenkins" {
  ami                    = "ami-0574da719dca65348" // Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2022-12-01
  instance_type          = var.instance_size
  vpc_security_group_ids = [aws_security_group.jenkins-sg.id]
  key_name               = aws_key_pair.generated_key.key_name
  user_data              = file("user-data.sh")
  tags = {
    Name  = "JenkinsServer Built by Terraform"
    Owner = "Mustofa Kodirov"
  }

  # connection {
  #   type        = "ssh"
  #   user        = "ubuntu"
  #   private_key = file("${path.module}/id_rsa")
  #   host        = self.public_ip
  # }
  # provisioner "remote-exec" {
  #   inline = [
  #     "ifconfig > /tmp/ifconfig.output",
  #     "echo 'hello gaurav'>/tmp/test.txt"
  #   ]
  # }
  # provisioner "remote-exec" {
  #   script = "./testscript.sh"
  # }
}

resource "aws_security_group" "jenkins-sg" {
  name        = "Jenkins-SG"
  description = "Security Group for my JenkinsServer"
  vpc_id      = aws_default_vpc.default.id # This need to be added since AWS Provider v4.29+ to set VPC id

  dynamic "ingress" {
    for_each = ["80", "8080", "8000", "22"]
    content {
      description = "Allow port HTTP"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    description = "Allow all ports"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "JenkinsServer SG by Terraform"
    Owner = "Mustofa Kodirov"
  }
}