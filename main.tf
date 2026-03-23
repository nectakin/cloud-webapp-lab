provider "aws" {
  region     = "eu-north-1"
}

resource "aws_security_group" "web_sg" {
  name = "web-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami           = "ami-0c1ac8a41498c1a9c" # Ubuntu (eu-north-1)
  instance_type = "t3.micro"

  key_name = "lab-key"   # ВАЖЛИВО: ім’я ключа в AWS

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "terraform-server"
  }
}
