# Creat application load balancer
resource "aws_lb" "magento_app_elb" {
  depends_on = [ aws_subnet.public_subnet_1, aws_subnet.public_subnet_2, aws_security_group.magento_app_security_group ]
  load_balancer_type = "application"
  security_groups    = [aws_security_group.magento_app_security_group.id]
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]

  #enable_deletion_protection = true

  #access_logs {
  #  bucket  = aws_s3_bucket.lb_logs.id
  #  prefix  = "test-lb"
  #  enabled = true
  #}

  tags = {
    Environment = "production"
  }
}

# Create application load balancer target group
resource "aws_lb_target_group" "magento_app_target_group" {
  depends_on = [ aws_vpc.main ]
  #target_type = "alb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/"
    interval            = 180
    timeout             = 120
    healthy_threshold   = 10
    unhealthy_threshold = 10
  }
}

# Create application load balancer listener
resource "aws_lb_listener" "magento_app_listener" {
  depends_on = [ aws_lb.magento_app_elb, aws_lb_target_group.magento_app_target_group ]
  load_balancer_arn = aws_lb.magento_app_elb.arn
  port              = 80
  protocol          = "HTTP"
  #ssl_policy        = "ELBSecurityPolicy-2016-08"
  #certificate_arn   = "arn:aws:acm:us-east-1:007741065220:certificate/a069c4c2-cf77-46da-b314-80c63269f65e"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.magento_app_target_group.arn
  }
}