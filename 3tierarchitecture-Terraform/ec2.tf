

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}


resource "aws_instance" "PublicWebTemplate" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public-web-subnet-1.id
  vpc_security_group_ids = [aws_security_group.webserver-security-group.id]
  key_name               = "mykey"
  user_data              = file("install-apache.sh")

  tags = {
    Name = "web-asg"
  }
}

resource "aws_key_pair" "mykey"{
    key_name = "mykey"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDNG6IftaLviKJ2odTfiAH0NHpPwBtXYhaO/Snmw60qKmLHAPf40zw7YVakRja92dOJsVBXn2pLMLDkC/Wvt1I28TKgx7GL5mpNbsJ/SBD/C5BXvAbSxsMB/gYj1i5Neq1wyJ2XWV6xSK6oz5iFP4ExwkV+iBQsHWcTFhHdvpO8XeiPYfuBWVQDSYnwfec67pR2F/LECnHsWsJC+2/Y5mXK/kjt7WVRK+ZXgtxqjm2+46BznWuJC95pl5eqnsNA9oMmYhPyIVmYTGFqODaICH2zBiTcTqhQdE6Zus2lNDK/8C2ow06cfGnlJE0ygFHVSaHpN78tvgKZh4lESACp9cZRXxAcqYnmjrIR4s8CP5r1r84fFBSCIbigsmngIcBHSvp5k84seBrxHamXPGiRw6v/rqyCWilwDz+EOxk0SVyGHBsOcMJI3cTDTBOx5MkwqT9YcGDCdpogjzSQDVNBzYswbTIuqHWEvAL7+C6vku/rgpRc34nCqOHqo9uqAXSxPyU= root@del1-lhp-n72251"
  }





resource "aws_instance" "private-app-template" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private-app-subnet-1.id
  vpc_security_group_ids = [aws_security_group.ssh-security-group.id]
  key_name               = "mykey"

  tags = {
    Name = "app-asg"
  }
}






