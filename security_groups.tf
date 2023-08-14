# Configure security group eic to instance
resource "aws_security_group" "eic_security_group_instance" {
    depends_on = [ aws_vpc.main ]
    name_prefix = "eic_security_group_instance"
    vpc_id = aws_vpc.main.id
    ingress = [   
        {
        description = "SSH from VPC"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [aws_vpc.main.cidr_block]
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        security_groups = []
        self = false
        }        
    ] 
}

# Configure security group to instance connect endpoint
resource "aws_security_group" "eic_security_group" {
    depends_on = [ aws_vpc.main ]
    name_prefix = "eic_security_group"
    vpc_id = aws_vpc.main.id

    egress = [
        {
        description = "EIC SSH VPC"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [aws_vpc.main.cidr_block]
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        security_groups = []
        self = false
        }
    ]    
}

# Configure security group to mysql
resource "aws_security_group" "mysql_security_group" {
    depends_on = [ aws_vpc.main ]
    name_prefix = "mysql_security_group"
    vpc_id = aws_vpc.main.id

    ingress = [   
        {
        description = "MYSQL from VPC"
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = [aws_vpc.main.cidr_block]
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        security_groups = []
        self = false
        }        
    ]
   
    egress = [
        {
        description = "MYSQL to VPC"
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = [aws_vpc.main.cidr_block]
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        security_groups = []
        self = false
        }
    ]    
}

# Configure security group to magento app
resource "aws_security_group" "magento_app_security_group" {
    depends_on = [ aws_vpc.main ]
    name_prefix = "magento_app_security_group"
    vpc_id = aws_vpc.main.id

    ingress = [
        {
        description = "HTTP from anywhere"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        security_groups = []
        self = false
        },
    
        {
        description = "SSH from anywhere"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        security_groups = []
        self = false
        }        
    ]

    egress = [
        {
        description = "Outbound traffic to anywhere"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        security_groups = []
        self = false
        }
    ]    
}

# Configure security group to efs for app files
resource "aws_security_group" "efs_app_files_security_group" {
    depends_on = [ aws_vpc.main ]
    name_prefix = "efs_app_files_security_group"
    vpc_id = aws_vpc.main.id

    ingress = [   
        {
        description = "EFS from VPC"
        from_port = 2049
        to_port = 2049
        protocol = "tcp"
        cidr_blocks = [aws_vpc.main.cidr_block]
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        security_groups = []
        self = false
        }        
    ]
   
    egress = [
        {
        description = "EFS to VPC"
        from_port = 2049
        to_port = 2049
        protocol = "tcp"
        cidr_blocks = [aws_vpc.main.cidr_block]
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        security_groups = []
        self = false
        }
    ]
}

