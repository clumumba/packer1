# packer plugin for AWS
# https://www.packer.io/plugins/builders/amazon

packer {
  required_plugins {
    amazon = {
      version = " >= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

# Which AMI to use as the base and where to save it
source "amazon-ebs" "amazon-linux" {
  region        = "us-east-2"
  ami_name      = "ami-version-1.0.1-{{timestamp}}"
  instance_type = "t2.micro"
  source_ami    = "ami-04f767d954fe2d2d1"
  ssh_username  = "ec2-user"
}

# What to install, configure, and which files to copy/execute
build {
  name    = "packer-aws-ami"
  sources = ["source.amazon-ebs.amazon-linux"]

  provisioner "shell" {
    script = "./provisioner.sh"
  }
}