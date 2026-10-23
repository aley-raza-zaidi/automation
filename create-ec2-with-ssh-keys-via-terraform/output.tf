output "public_ip" {
  value = aws_instance.ec2_example.public_ip
}

output "ssh_commands" {
  value = "ssh -i ${path.root}/az-key-pair.pem ec2-user@${aws_instance.ec2_example.public_ip}"
  sensitive = true
}

