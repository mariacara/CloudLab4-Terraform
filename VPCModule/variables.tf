# creates vpc cidr block variable
variable "vpc_cidr" {
  description = "cidr block of the vpc"
  default     = "100.64.0.0/16"
}

# creates public subnet cidr block
variable "public_cidr" {
  description = "cidr block of the public subnets"
  default     = "100.64.1.0/24"
}

# creates private subnet cidr block
variable "private_cidr" {
  description = "cidr block of the private subnet"
  default     = "100.64.2.0/24"
}