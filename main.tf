provider "aws"{
	region = "us-east-1"
	access_key = ""
	secret_access_key = ""
}


resource "aws_instance" "Server-1" {
  ami           = "ami-005e54dee72cc1d00" 
  instance_type = "t2.micro"
  security_group = [aws_security_group.TerraformEc2_security.name]
  subnet = [aws_public_subnet.Public_subnet.cidr_block]
  key_name = "Terraform_key"
tags = {
   Name = "Terraform-EC2"
   Department = "DevOps"
}
}

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/27"
  instance_tenancy = "default"

  tags = {
    Name = "VPC1"
  }
}
resource "aws_private_subnet" "Private_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/28"

  tags = {
    Name = "Private_subnet"
  }
}
resource "aws_public_subnet" "Public-subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.17/24"

  tags = {
    Name = "Public_subnet"
  }
}

resource "aws_security_group" "TeraformEC2_security" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  
ingress {
    description      = "inboud rulefrom VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.main.cidr_block]
  }
 ingress {
    description      = "inboud rulefrom VPC"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "TeraformEC2_security"
  }
}
