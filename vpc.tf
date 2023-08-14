# Create main VPC
resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    
    tags = {
      Name = "main"
    }
}

#Create public subnet 1
resource "aws_subnet" "public_subnet_1" {
    depends_on = [ aws_vpc.main ]
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"

    tags = {
      Name = "public_subnet_1"
    }
}

#Create public subnet 2
resource "aws_subnet" "public_subnet_2" {
    depends_on = [ aws_vpc.main ]
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"

    tags = {
      Name = "public_subnet_2"
    }
}

#Create private subnet 1
resource "aws_subnet" "private_subnet_1" {
    depends_on = [ aws_vpc.main ]
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "us-east-1a"

    tags = {
      Name = "private_subnet_1"
    }
}

#Create private subnet 2
resource "aws_subnet" "private_subnet_2" {
    depends_on = [ aws_vpc.main ]
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.4.0/24"
    availability_zone = "us-east-1b"

    tags = {
      Name = "private_subnet_2"
    }
}

#Create private subnet 3
resource "aws_subnet" "private_subnet_3" {
    depends_on = [ aws_vpc.main ]
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.5.0/24"
    availability_zone = "us-east-1a"

    tags = {
      Name = "private_subnet_3"
    }
}

#Create private subnet 4
resource "aws_subnet" "private_subnet_4" {
    depends_on = [ aws_vpc.main ]
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.6.0/24"
    availability_zone = "us-east-1b"

    tags = {
      Name = "private_subnet_4"
    }
}

# Create internet gateway for public subnets
resource "aws_internet_gateway" "internet_gateway" {
    depends_on = [ aws_subnet.public_subnet_1, aws_subnet.public_subnet_2 ]
    vpc_id = aws_vpc.main.id
}

# Create route for public subnets
resource "aws_route_table" "public_route_table" {
    depends_on = [ aws_internet_gateway.internet_gateway ]
    vpc_id = aws_vpc.main.id
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.internet_gateway.id
    }
}

# Create route association for public subnet 1
resource "aws_route_table_association" "public_subnet1_association" {
    depends_on = [ aws_route_table.public_route_table ]
    subnet_id = aws_subnet.public_subnet_1.id
    route_table_id = aws_route_table.public_route_table.id
}

# Create route association for public subnet 2
resource "aws_route_table_association" "public_subnet2_association" {
    depends_on = [ aws_route_table.public_route_table ]
    subnet_id = aws_subnet.public_subnet_2.id
    route_table_id = aws_route_table.public_route_table.id
}

#Configura instance connect endpoint on public subnet 1
#resource "aws_ec2_instance_connect_endpoint" "eic_public_subnet_1" {
#    preserve_client_ip = false
#    subnet_id = aws_subnet.public_subnet_1.id
#    security_group_ids = [ aws_security_group.eic_security_group.id ]
#}

#Configura instance connect endpoint on public subnet 2
#resource "aws_ec2_instance_connect_endpoint" "eic_public_subnet_2" {
#    preserve_client_ip = false
#    subnet_id = aws_subnet.public_subnet_2.id
#    security_group_ids = [ aws_security_group.eic_security_group.id ]

#}

