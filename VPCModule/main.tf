# data source to allow access to the list of AWS availability zones within the region
data "aws_availability_zones" "az" {
  state = "available"
}

# create the new vpc
resource "aws_vpc" "mc-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    "Name" = "MC-VPC1"
  }
}

# create the public subnets
resource "aws_subnet" "public" {
  cidr_block              = var.public_cidr
  vpc_id                  = aws_vpc.mc-vpc.id
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.az.names[0]
}

# create the private subnets
resource "aws_subnet" "private" {
  cidr_block        = var.private_cidr
  vpc_id            = aws_vpc.mc-vpc.id
  availability_zone = data.aws_availability_zones.az.names[1]
}

# create the internet gateway for the public subnets
resource "aws_internet_gateway" "mc-igw" {
  vpc_id = aws_vpc.mc-vpc.id
  tags = {
    "Name" = "mc-igw"
  }
}

# create public route table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.mc-vpc.id
}

# create a public route
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.mc-igw.id
}

# associate public subnets to public route table
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}

# create private route table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.mc-vpc.id
}

# create EIP for nat gateway
resource "aws_eip" "mc_eip" {
  vpc = true
}

# create NAT gateway
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.mc_eip.id
  subnet_id     = aws_subnet.public.id
  tags = {
    "Name" = "NAT gw public subnet"
  }
}

# create a private route
resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id
}

# associate private subnets to private route table
resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private_rt.id
}