# Create subnet group
resource "aws_db_subnet_group" "db_subnet_group" {
    name = "private"
    subnet_ids = [aws_subnet.private_subnet_3.id, aws_subnet.private_subnet_4.id]
}

# Create rds database instance
resource "aws_db_instance" "magento_db_mysql" {
    depends_on = [ aws_subnet.private_subnet_3, aws_security_group.mysql_security_group, aws_subnet.private_subnet_4 ]
    allocated_storage = 20
    storage_type = "gp2"
    db_name = "magento"  
    engine = "mysql"
    engine_version = "8.0.28"
    instance_class = "db.m5.large"
    username = "magento"
    password = "magento23"
    db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
    vpc_security_group_ids = [aws_security_group.mysql_security_group.id]
    skip_final_snapshot = true
    multi_az = true
}

