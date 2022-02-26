resource "aws_instance" "my-web-server" {
  ami                    = "ami-033b95fb8079dc481"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.webserver-security-group.id]
  subnet_id              = aws_subnet.private-subnet-1.id
  key_name               = "my-key"
  user_data     = <<-EOF
                  #!/bin/bash
                  sudo su
                  yum -y install httpd
                  echo "<p> my-web-server </p>" >> /var/www/html/index.html
                  sudo systemctl enable httpd
                  sudo systemctl start httpd
                  EOF
  tags = {
    Name = "My Web Server Terraform"
  }
}

output "server_private_ip" {
  value = aws_instance.my-web-server.private_ip

}

output "server_id" {
  value = aws_instance.my-web-server.id
}


