# creates output for the vpc id
output "vpc_id" {
  value = aws_vpc.mc-vpc.id
}

# creates output for the public subnet id
output "pub_sub" {
  value = aws_subnet.public.id
}

# creates output for the private subnet id
output "priv_sub" {
  value = aws_subnet.private.id
}