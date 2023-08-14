# Create efs for app files
resource "aws_efs_file_system" "magento_app_files" {
    depends_on = [ aws_subnet.private_subnet_1, aws_subnet.private_subnet_2, aws_security_group.efs_app_files_security_group ]
    creation_token = "magento_app"
}

# Create mount target for the private subnet 1
resource "aws_efs_mount_target" "app_mount_1" {
    depends_on = [ aws_efs_file_system.magento_app_files ]
    file_system_id = aws_efs_file_system.magento_app_files.id
    subnet_id = aws_subnet.private_subnet_1.id
    security_groups = [ aws_security_group.efs_app_files_security_group.id ]
}

# Create mount target for the private subnet 2
resource "aws_efs_mount_target" "app_mount_2" {
    depends_on = [ aws_efs_file_system.magento_app_files ]
    file_system_id = aws_efs_file_system.magento_app_files.id
    subnet_id = aws_subnet.private_subnet_2.id
    security_groups = [ aws_security_group.efs_app_files_security_group.id ]
}