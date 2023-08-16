terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.12.0"
    }
  }
}


provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}



### CRIANDO SECURITY GROUP PARA APLICAR REGRAS DE SEGURANÇA DE REDE NAS INSTACIAS A SEREM CRIADAS
resource "aws_security_group" "k8s" {
  name        = "k8s"
  description = "Permite trafego k8s"

  ingress {
    description      = "Libera ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "libera ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "Libera http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "libera http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "Libera https"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "libera https"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  



  tags = {
    Name = "k8s"
  }
}


### CRIA KEYPAIR PARA UTILIZAÇÃO NA EC2
resource "aws_key_pair" "tfkey" {
  key_name   = "tfkey"
  public_key = "AQUI COLOCO A CHAVE PUBLICA DA MINHA MÁQUINA PARA OBTER O ACESSO SSH"
}


### DEFININDO BUSCA PELA AMI MAIS RECENTE DO UBUNTU 
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}


### INICIANDO CONSTRUÇAO DA MINHA INSTANCIA
resource "aws_instance" "this" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  tags = {
    Name = "instancia-ubuntu"
  }
  key_name = "tfkey"
  security_groups = ["k8s"]
}