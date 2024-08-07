resource "aws_lb_target_group" "mydomain_target" {
  name     = "mydomain-targets"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
    healthy_threshold   = 2
  }
}

resource "aws_lb_target_group_attachment" "target_ec2" {
  target_group_arn = aws_lb_target_group.mydomain_target.arn
  target_id        = var.instance_id
  port             = 80
}
