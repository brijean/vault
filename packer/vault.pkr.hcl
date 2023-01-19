packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}


variable "aws_region" {
  type    = string
  default = "us-east-2"
}

variable "vault_zip" {
  type    = string
  default = "C:\\Users\\brianjea\\Downloads\\vault_1.12.2_linux_386.zip"
}

variable "vpc_id" {
  type    = string
  default = "vpc-8aab7ae2"
}

variable "subnet_id" {
  type    = string
  default = "subnet-ec3ae484"
}

data "amazon-ami" "amazon-linux-2" {
  filters = {
    name                = "amzn2-ami-hvm-2.*-x86_64-gp2"
    root-device-type    = "ebs"
    virtualization-type = "hvm"
  }
  most_recent = true
  owners      = ["amazon"]
  region      = var.aws_region
}

source "amazon-ebs" "amazon-ebs-amazonlinux-2" {
  ami_description             = "Vault - Amazon Linux 2"
  ami_name                    = "vault-amazonlinux2-vault-Base"
  ami_regions                 = ["us-east-2"]
  ami_virtualization_type     = "hvm"
  associate_public_ip_address = true
  force_delete_snapshot       = true
  force_deregister            = true
  instance_type               = "t2.micro"
  region                      = var.aws_region
  source_ami                  = data.amazon-ami.amazon-linux-2.id
  spot_price                  = "0"
  ssh_pty                     = true
  ssh_timeout                 = "5m"
  ssh_username                = "ec2-user"
  tags = {
    Name = "HashiCorp Vault"
    OS   = "Amazon Linux 2"
  }
  subnet_id = var.subnet_id
  vpc_id    = var.vpc_id
}

build {
  sources = ["source.amazon-ebs.amazon-ebs-amazonlinux-2"]

  provisioner "file" {
    destination = "/tmp/vault.zip"
    source      = var.vault_zip
  }
  provisioner "file" {
    destination = "/tmp"
    source      = "files/"
  }
  provisioner "shell" {
    script = "./files/vault_setup.sh"
  }
}