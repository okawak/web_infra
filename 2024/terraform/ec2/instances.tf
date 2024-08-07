resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file(var.key_name)
}

resource "aws_security_group" "ec2_sg" {
  name        = "allow_ssh_http"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "WireGuard"
    from_port   = 51820
    to_port     = 51820
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "vps_home" {
  ami                    = var.ec2_ami
  instance_type          = var.ec2_instance_type
  key_name               = aws_key_pair.deployer.key_name
  subnet_id              = var.public_subnet
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo dnf -y update --releasever=latest
              EOF

  tags = {
    Name = "terraform VPS"
  }
}

resource "aws_eip" "ec2_eip" {
  instance = aws_instance.vps_home.id
  domain   = "vpc"
}
