variable "region" {
  description = "AWS region in which resources are created."
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public EC2 subnet."
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_db_subnet_a_cidr" {
  description = "CIDR block for the first private database subnet."
  type        = string
  default     = "10.0.10.0/24"
}

variable "private_db_subnet_b_cidr" {
  description = "CIDR block for the second private database subnet."
  type        = string
  default     = "10.0.11.0/24"
}

variable "availability_zone_a" {
  description = "First Availability Zone."
  type        = string
  default     = "us-east-1a"
}

variable "availability_zone_b" {
  description = "Second Availability Zone."
  type        = string
  default     = "us-east-1b"
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Name of an existing EC2 key pair."
  type        = string
}

variable "ssh_cidr" {
  description = "CIDR permitted to connect to the EC2 instance over SSH. Prefer your own public IP as /32."
  type        = string
}

variable "db_username" {
  description = "RDS administrator username."
  type        = string
  default     = "appadmin"
}

variable "db_password" {
  description = "RDS administrator password. Supply securely; never commit it."
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Initial MySQL database name."
  type        = string
  default     = "appdb"
}
