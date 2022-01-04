provider "aws" {
  profile = "default"
  region = "us-east-2"
}
resource "aws_lb" "abcd" {
  name               = "test-lb-tf1"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["sg-0188068a44c521d97"]
  subnets            = ["subnet-02ac0c9e52da309ab","subnet-08f3fd927977dc180",]
}
resource "aws_lb_target_group" "abcd" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-0a7387e5c61ec7456"
}
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.abcd.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.abcd.arn
  }
}
resource "aws_lb_target_group_attachment" "abcd" {
  target_group_arn = aws_lb_target_group.abcd.arn
  target_id        = "ii-03f429574f46d2e9f"
  port             = 80
}
