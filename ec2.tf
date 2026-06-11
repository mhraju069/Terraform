resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = file("mykey.pub")
}


resource "aws_default_vpc" "default" {

}


resource "aws_security_group" "sg" {
  name        = "devops-sg"
  description = "Allow SSH and HTTP access"
  vpc_id      = aws_default_vpc.default.id
  tags = {
    Name = "devops-sg"
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
  key_name        = aws_key_pair.mykey.key_name
  security_groups = [aws_security_group.sg.name]
  instance_type   = "t3.micro"
  ami             = "ami-0c02cf818fceb9254" #amazon linux
  root_block_device {
    volume_size           = 8
    volume_type           = "gp3"
    delete_on_termination = true
  }
  tags = {
    Name = "devops-ec2"
  }

  user_data = <<-EOF
      #!/bin/bash
      yum update -y
      yum install -y httpd
      systemctl start httpd
      systemctl enable httpd
      echo "<h1>Hello World from Terraform</h1>" > /var/www/html/index.html
      EOF


}
