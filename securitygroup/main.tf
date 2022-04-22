# creates variable vpc to be used to call from the module vpc
variable "vpc" {}

# creates the web-sg security group allowing ssh and http
resource "aws_security_group" "web-sg" {
  name        = "web-sg"
  description = "Allows HTTP and SSH traffic"
  vpc_id      = var.vpc

  ingress {
    description = "allow SSH traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-web-mclab4"
  }
}