# gets the latest AWS AMI image
data "aws_ami" "ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"]
}

# creates ec2 instance within the public subnet
resource "aws_instance" "pub_web" {
  count                  = var.counter
  ami                    = data.aws_ami.ami.id
  instance_type          = var.instance_type
  subnet_id              = var.pub_sub
  vpc_security_group_ids = [var.sg]
  key_name               = var.key
  user_data              = file("./webserver/userdata.sh")
  tags = {
    Name = "PublicWeb-${count.index + 1}"
  }
}

# creates ec2 instance within the private subnet
resource "aws_instance" "priv_web" {
  count                  = var.counter
  ami                    = data.aws_ami.ami.id
  instance_type          = var.instance_type
  subnet_id              = var.priv_sub
  vpc_security_group_ids = [var.sg]
  key_name               = var.key
  user_data              = file("./webserver/userdata.sh")
  tags = {
    Name = "PrivateWeb-${count.index + 1}"
  }
}