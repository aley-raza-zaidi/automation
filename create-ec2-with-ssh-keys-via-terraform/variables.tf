variable "aws_key_name" {
  description = "Key Pair to use"
  type        = string
  default     = "az-key-pair"
}

variable "aws_ami_image" {
  description = "ubbuntu"
  type        = string
  default     = "ami-04a0530fbdaac2fd6"
}

variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "eu-central-1"
}

variable "aws_instance_type" {
  description = "Free tier instance"
  type        = string
  default     = "t8i.micro"
}
