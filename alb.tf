resource "aws_lb" "app_lb" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = values(module.vpc_nfw.public_subnets)
}

resource "aws_lb_target_group" "app_tg" {
  name     = "coalfire-app-tg"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = module.vpc_nfw.vpc_id

  health_check {
    protocol = "HTTP"
    path     = "/"
    port     = "443"
  }
}

resource "aws_lb_listener" "app_lb_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.app.name
  lb_target_group_arn   = aws_lb_target_group.app_tg.arn
}