provider "aws" {
  region = "us-east-1" 
}

# Create Security Group 
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh" 
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

# Create EC2 Instance 
resource "aws_instance" "test" {
  ami           = "ami-080e1f13689e07408"
  instance_type = "t2.micro"
  key_name      = "haitham" 
  tags = {
    Name = "TestServer" 
  }
}

# output Ip address 
resource "local_file" "inventory_file" {
  filename = "inventory" 
  content  = <<-EOT
[nginx]
${aws_instance.test.public_ip}
EOT
}
