resource "aws_lb_listener" "error" {
  load_balancer_arn = aws_lb.main.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.acm_certificate_arn

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Error Page"
      status_code  = "503"
    }
  }
}

resource "aws_lb_listener_rule" "forward_rule" {
  listener_arn = aws_lb_listener.error.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.mydomain_target.arn
  }

  condition {
    host_header {
      values = ["alb.${var.domain}"]
    }
  }

  condition {
    http_header {
      http_header_name = var.random_name
      values           = [var.random_value]
    }
  }
}

#resource "aws_lb_listener" "https" {
#  load_balancer_arn = aws_lb.main.arn
#  port              = "443"
#  protocol          = "HTTPS"
#  ssl_policy        = "ELBSecurityPolicy-2016-08"
#  certificate_arn   = var.acm_certificate_arn
#
#  default_action {
#    type             = "forward"
#    target_group_arn = aws_lb_target_group.mydomain_target.arn
#  }
#}
#
#resource "aws_lb_listener_rule" "http_header_based_routing" {
#  listener_arn = aws_lb_listener.front_end.arn
#  priority     = 10
#
#  action {
#    type             = "forward"
#    target_group_arn = aws_lb_target_group.tg.arn
#  }
#
#  condition {
#    http_header {
#      http_header_name = "User-Agent"
#      values = [
#        "*Chrome*",
#        "*Safari*",
#      ]
#    }
#  }
#}
