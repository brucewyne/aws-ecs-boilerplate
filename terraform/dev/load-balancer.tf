resource "aws_lb" "dev" {
  name               = "lb-dev"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [aws_subnet.main.id, aws_subnet.secondary.id]

  enable_deletion_protection = false

  tags = {
    Name = "Load Balancer - dev"
  }
}

resource "aws_lb_listener" "dev" {
  load_balancer_arn = aws_lb.dev.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Nothing to see"
      status_code  = "404"
    }
  }
}

