
packer {
  required_plugins {
    amazon = {
      version = " >= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "ansible-ubuntu-ami-2"
  instance_type = "t2.micro"
  region        = "us-east-2"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"  # Use the latest available Ubuntu 20.04 AMI
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]  # Canonical account ID for Ubuntu AMIs
  }
  ssh_username = "ubuntu"
}

build {
  name    = "ansible-packer"
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "shell" {
    script = "./ansible.sh"
  }
}

