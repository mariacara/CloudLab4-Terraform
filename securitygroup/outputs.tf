# creates an output for the security group id
output "sg-id" {
  value = aws_security_group.web-sg.id
}