# please enter your access and secret key from aws account
provider "aws" {
  region = var.aws_region
  access_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  secret_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}

# Generate RSA private key
resource "tls_private_key" "az-keypair" {
  algorithm = "RSA"
  rsa_bits  = 2048
}


# Save private key to local file
resource "local_file" "private_key" {
  content         = tls_private_key.az-keypair.private_key_pem
  filename        = "${path.root}/az-key-pair.pem"
  file_permission = "0400"
}

# Create AWS Key Pair using the generated public key
resource "aws_key_pair" "az-keypair" {
  key_name   = "az-key-pair"
  public_key = tls_private_key.az-keypair.public_key_openssh
}

# Deploy an EC2 Instance with given ami image and instance type
resource "aws_instance" "ec2_example" {
  ami           = var.aws_ami_image
  instance_type = var.aws_instance_type
  key_name      = aws_key_pair.az-keypair.key_name

  tags = {
    Name = "Terraform EC2"
  }
}


