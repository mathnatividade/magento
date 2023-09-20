terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-2"
}

# Create a launch template for the auto scalling
resource "aws_launch_template" "magento_app" {
    image_id = "ami-09538990a0c4fe9be" #Amazon Linux 2
    instance_type = "t2.micro"
    vpc_security_group_ids = [ aws_security_group.magento_app_security_group.id, aws_security_group.eic_security_group_instance.id, aws_security_group.mysql_security_group.id, aws_security_group.efs_app_files_security_group.id ]
    
    key_name = aws_key_pair.create_key_pair.key_name 

    user_data = filebase64("user_data.sh")

    tags = {
      Name = "Web Server"
    } 
}

# Associate registered domain in the alb
resource "aws_route53_record" "magento_app_site" {
  zone_id = "zoneID"  
  name    = "cname.desejado.aqui"
  type    = "A"

  alias {
    name                   = aws_lb.magento_app_elb.dns_name
    zone_id                = aws_lb.magento_app_elb.zone_id
    evaluate_target_health = true
  }
}

