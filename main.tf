terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.16"
    }
  }
  required_version = "~>1.5.4"
}

provider "aws" {
  region  = "us-east-1"
  profile = "ronte"

}
resource "aws_instance" "instance-example" {
  ami                    = ""
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.example-sg.id]
  user_data              = <<-EOF
     echo "Welcome to my  Webpage">index.html
     nohup busybox -f -p 8080 &
     EOF
}
resource "aws_security_group" "example-sg" {
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
