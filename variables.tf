variable "ec2_instance_type" {
    type    = string
    default = "t3.micro"
}

variable "ec2_volume_size" {
    type    = number
    default = 8
}

variable "ec2_volume_type" {
    type    = string
    default = "gp3"
}

variable "ami_id" {
    type    = string
    default = "ami-0c02cf818fceb9254"
}

variable "key_name" {
    type    = string
    default = "mykey"
}

variable "security_group_name" {
    type    = string
    default = "devops-sg"
}