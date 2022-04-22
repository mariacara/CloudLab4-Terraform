# declare the output variables that will be referenced
variable "sg" {}
variable "vpc" {}
variable "pub_sub" {}
variable "priv_sub" {}

# variable for the instance type of the webserver
variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

# variable for the key used for the ec2 instances
variable "key" {
  description = "EC2 Key Name"
  default     = "demo-key"
}

# counter for the vm tag
variable "counter" {
  default = 1
}