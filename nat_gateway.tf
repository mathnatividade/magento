# Allocate public ip for NAT gateway 1
resource "aws_eip" "nat_gw_eip_1" {
    depends_on = [ aws_vpc.main ]
    domain = "vpc"
}

# Allocate public ip for NAT gateway 2
resource "aws_eip" "nat_gw_eip_2" {
    depends_on = [ aws_vpc.main ]
    domain = "vpc"
}

# Create NAT gateway 1
resource "aws_nat_gateway" "nat_gw_1" {
  depends_on = [aws_internet_gateway.internet_gateway, aws_subnet.public_subnet_1]
  subnet_id     = aws_subnet.public_subnet_1.id
  allocation_id = aws_eip.nat_gw_eip_1.id
}

# Create route for NAT gateway to private subnets
resource "aws_route_table" "private_nat_route_table_1" {
    depends_on = [ aws_vpc.main ]
    vpc_id = aws_vpc.main.id
}

resource "aws_route" "private_nat_route_1" {
  depends_on = [ aws_nat_gateway.nat_gw_1, aws_route_table.private_nat_route_table_1 ]
  route_table_id         = aws_route_table.private_nat_route_table_1.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw_1.id
}

# Create route association for private subnet 1 on az 1
resource "aws_route_table_association" "private_subnet1_association" {
    depends_on = [ aws_route_table.private_nat_route_table_1, aws_subnet.private_subnet_1 ]
    subnet_id = aws_subnet.private_subnet_1.id
    route_table_id = aws_route_table.private_nat_route_table_1.id
}

# Create route association for private subnet 3 on az 1
resource "aws_route_table_association" "private_subnet3_association" {
    depends_on = [ aws_route_table.private_nat_route_table_1, aws_subnet.private_subnet_3 ]
    subnet_id = aws_subnet.private_subnet_3.id
    route_table_id = aws_route_table.private_nat_route_table_1.id
}

# Create NAT gateway 2
resource "aws_nat_gateway" "nat_gw_2" {
  depends_on = [aws_internet_gateway.internet_gateway, aws_subnet.public_subnet_2]
  subnet_id     = aws_subnet.public_subnet_2.id
  allocation_id = aws_eip.nat_gw_eip_2.id
}

# Create route for NAT gateway to private subnets
resource "aws_route_table" "private_nat_route_table_2" {
    depends_on = [ aws_vpc.main ]
    vpc_id = aws_vpc.main.id
}

resource "aws_route" "private_nat_route_2" {
  depends_on = [ aws_nat_gateway.nat_gw_2, aws_route_table.private_nat_route_table_2 ]
  route_table_id         = aws_route_table.private_nat_route_table_2.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw_2.id
}

# Create route association for private subnet 2 on az 2
resource "aws_route_table_association" "private_subnet2_association" {
    depends_on = [ aws_route_table.private_nat_route_table_2, aws_subnet.private_subnet_2 ]
    subnet_id = aws_subnet.private_subnet_2.id
    route_table_id = aws_route_table.private_nat_route_table_2.id
}

# Create route association for private subnet 4 on az 2
resource "aws_route_table_association" "private_subnet4_association" {
    depends_on = [ aws_route_table.private_nat_route_table_2, aws_subnet.private_subnet_4 ]
    subnet_id = aws_subnet.private_subnet_4.id
    route_table_id = aws_route_table.private_nat_route_table_2.id
}