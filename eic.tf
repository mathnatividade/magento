#Configura instance connect endpoint on public subnet 1
resource "aws_ec2_instance_connect_endpoint" "eic_public_subnet_1" {
    preserve_client_ip = false
    subnet_id = aws_subnet.public_subnet_1.id
    security_group_ids = [ aws_security_group.eic_security_group.id ]
}

#Configura instance connect endpoint on public subnet 2
resource "aws_ec2_instance_connect_endpoint" "eic_public_subnet_2" {
    preserve_client_ip = false
    subnet_id = aws_subnet.public_subnet_2.id
    security_group_ids = [ aws_security_group.eic_security_group.id ]
}