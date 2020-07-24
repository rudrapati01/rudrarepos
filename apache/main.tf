resource "aws_instance" "test_instance" {

  ami           = "ami-0732b62d310b80e97"
  instance_type = "t2.micro"

  security_groups = ["${aws_security_group.hello-terra-ssh-http.name}"]
  key_name        = "july2020"


 user_data = <<-EOF
                #! /bin/bash
                sudo yum install httpd -y
                sudo systemctl start httpd
                sudo systemctl enable httpd
                echo "<h1>webserver created by terraform<h1/>" >> /var/www/html/index.html
        EOF



tags = {
    Name = "EC2 with ssh"
  }
  }



#creating the security group

resource "aws_security_group" "hello-terra-ssh-http" {
  name        = "hello-terra-ssh-http"
  description = "allowing ssh and http traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


