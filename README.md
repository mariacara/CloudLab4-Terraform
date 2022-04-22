# CloudLab4-Terraform
SYST35144 Cloud Systems Lab 4 - Terraform to create three modules to deploy infrastructure to AWS

The first module - VPCModule, creates the new VPC with a private and public subnet. It outputs the vpc id, and private and public subnet ids to be referenced in the webserver module.

The second module - securitygroup, creates a security group with two inbound rules allowing ssh and http

The third module - webserver, launches an ec2 webserver in the private and public subnet.
