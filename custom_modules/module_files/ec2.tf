resource "aws_key_pair" "mykey" {
  key_name   = "${var.key_name}-${var.env}"
  public_key = file("../${var.key_name}.pub")
}


resource "aws_default_vpc" "default" {}



resource "aws_security_group" "sg" {
  name        = "${var.security_group_name}-${var.env}"
  description = "Allow SSH and HTTP access"
  vpc_id      = aws_default_vpc.default.id
  tags = {
    Name = "${var.security_group_name}-${var.env}"
  }

  #inbound rules

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH access from anywhere"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH access from anywhere"
  }

  #outbound rules

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound access"
  }

}



resource "aws_instance" "myEC2" {

  count = var.instance_count

  key_name        = aws_key_pair.mykey.key_name
  security_groups = [aws_security_group.sg.name]
  instance_type   = var.ec2_instance_type
  ami             = var.ami_id
  root_block_device {
    volume_size           = var.ec2_volume_size
    volume_type           = var.ec2_volume_type
    delete_on_termination = true
  }
  tags = {
    Name = "${var.instance_name}-${var.env}"
    env  = var.env
  }

  user_data = <<-EOF
      #!/bin/bash
      yum update -y
      yum install -y httpd
      systemctl start httpd
      systemctl enable httpd
      echo "<h1>Hello World from Terraform for ${var.instance_name}-${var.env}</h1>" > /var/www/html/index.html
      EOF
}
