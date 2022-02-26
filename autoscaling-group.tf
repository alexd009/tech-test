resource "aws_launch_template" "web-scaling" {
  name_prefix   = "web-scaling"
  image_id      = "ami-033b95fb8079dc481"
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "web-asg" {
  availability_zones = ["us-east-1a", "us-east-1b"]
  desired_capacity   = 2
  max_size           = 5   
  min_size           = 2

  launch_template {
    id      = aws_launch_template.web-scaling.id
    version = "$Latest"
  }
}