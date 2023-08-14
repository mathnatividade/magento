# Create auto scalling group
resource "aws_autoscaling_group" "magento_asg" {
    depends_on = [ aws_subnet.private_subnet_1, aws_subnet.private_subnet_2, aws_launch_template.magento_app, aws_db_instance.magento_db_mysql ]
    min_size = 1
    max_size = 4
    desired_capacity = 2
    health_check_type = "ELB"
    vpc_zone_identifier = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
    launch_template {
      id = aws_launch_template.magento_app.id
      version = "$Latest"
    }
}

# Create auto scalling attachment
resource "aws_autoscaling_attachment" "magento_asg_attachment" {
    depends_on = [ aws_autoscaling_group.magento_asg, aws_lb.magento_app_elb ]
    autoscaling_group_name = aws_autoscaling_group.magento_asg.id
    lb_target_group_arn = aws_lb_target_group.magento_app_target_group.arn
}