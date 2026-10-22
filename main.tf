provider "aws" {
  region = "eu-central-1"
  access_key = "xxxxxxxxx"
  secret_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}

resource "aws_instance" "ec2_example" {
  ami = "ami-04a0530fbdaac2fd6"
  instance_type = "t8i.micro"
  tags = {
    Name = "Terraform EC2"  
  }
}
