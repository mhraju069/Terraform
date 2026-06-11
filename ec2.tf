resource "aws_key_pair" "mykey" {
  key_name   = var.key_name
  public_key = file("${var.key_name}.pub")
}


resource "aws_default_vpc" "default" {}



resource "aws_security_group" "sg" {
  name        = var.security_group_name
  description = "Allow SSH and HTTP access"
  vpc_id      = aws_default_vpc.default.id
  tags = {
    Name = var.security_group_name
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

  for_each = tomap({
    ec2_1 = "t3.micro"
    ec2_2 = "t3.small"
  })

  key_name        = aws_key_pair.mykey.key_name
  security_groups = [aws_security_group.sg.name]
  instance_type   = each.value
  ami             = var.ami_id
  root_block_device {
    volume_size           = var.deployment_type == "dev" ? var.ec2_volume_size : 15
    volume_type           = var.ec2_volume_type
    delete_on_termination = true
  }
  tags = {
    Name = each.key
  }

  user_data = <<-EOF
      #!/bin/bash
      yum update -y
      yum install -y httpd
      systemctl start httpd
      systemctl enable httpd
      echo "<h1>Hello World from Terraform for ${each.key}</h1>" > /var/www/html/index.html
      EOF
}
