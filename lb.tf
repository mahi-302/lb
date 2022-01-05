provider "aws" {
  profile = "default"
  region = "us-east-2"
}
resource "aws_lb" "lb1" {
  name               = "lbtf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["sg-03723ff32a5606bda"]
  subnets            = ["subnet-0c9f6c09d2f62dc2d","subnet-08f3fd927977dc180","subnet-02ac0c9e52da309ab"]
}
resource "aws_lb_target_group" "lb1" {
  name     = "lbtgtf"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-0a7387e5c61ec7456"
}
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.lb1.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb1.arn
  }
}
resource "aws_lb_target_group_attachment" "lb1" {
  target_group_arn = aws_lb_target_group.lb1.arn
  target_id        = "i-0ae95d4c23948efa5"
  port             = 80
}
