variable "env" {
  description = "This is the environment name"
  type        = string
}

variable "bucket_name" {
  description = "This is the bucket name"
  type        = string
}


variable "key_name" {
  description = "This is the key name"
  type        = string
}


variable "instance_name" {
  description = "This is the instance name"
  type        = string
}

variable "instance_count" {
  description = "This is the instance count"
  type        = number
}

variable "security_group_name" {
  description = "This is the security group name"
  type        = string
}

variable "ec2_instance_type" {
  description = "This is the ec2 instance type"
  type        = string
}

variable "ec2_volume_size" {
  description = "This is the ec2 volume size"
  type        = number
}

variable "ec2_volume_type" {
  description = "This is the ec2 volume type"
  type        = string
}

variable "ami_id" {
  description = "This is the ami id"
  type        = string
}
