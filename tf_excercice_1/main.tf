provider "aws" {
  region     = "us-east-1"
  access_key = "...."
  secret_key = "...."
}

resource "aws_instance" "udacity_t2" {
  count = 4
  tags = {
    project = "udacity",
    Name = "Udacity T2"
  }
  ami = "ami-0c6b1d09930fac512"
  instance_type = "t2.micro"
  subnet_id = "subnet-0f7fa0bae406acc54"
}

resource "aws_instance" "udacity_m4" {
  count = 2
  tags = {
    project = "udacity",
    Name = "UdacityM4"
  }
  ami = "ami-0c6b1d09930fac512"
  instance_type = "m4.large"
  subnet_id = "subnet-0f7fa0bae406acc54"
}
