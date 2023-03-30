provider "aws" {
  region = "us-east-1"
}

# Create a VPC with a CIDR block of 10.0.0.0/16
resource "aws_vpc" "test-vpc" {
  cidr_block = "10.0.0.0/16"
}

# Create an internet gateway and attach it to the VPC
resource "aws_internet_gateway" "i-gateway" {
  vpc_id = aws_vpc.test-vpc.id
}

# Create three public subnets in three AZs
resource "aws_subnet" "public" {
  count                   = 3
  cidr_block              = "10.0.${count.index}.0/24"
  vpc_id                  = aws_vpc.test-vpc.id
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

# Create three private subnets in three AZs
resource "aws_subnet" "private" {
  count             = 3
  cidr_block        = "10.0.${count.index + 10}.0/24"
  vpc_id            = aws_vpc.test-vpc.id
  availability_zone = "us-east-1a"
}

# Create a route table for the public subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.test-vpc.id
}

# Associate the public subnets with the public route table
resource "aws_route_table_association" "public" {
  count          = 3
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Create a NAT gateway in the first public subnet
resource "aws_nat_gateway" "test-vpc" {
  allocation_id = aws_eip.test-vpc.id
  subnet_id     = aws_subnet.public[0].id
}

# Create an EIP for the NAT gateway
resource "aws_eip" "test-vpc" {
  vpc = true
}

# Create a route table for the private subnets
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.test-vpc.id
}

# Associate the private subnets with the private route table
resource "aws_route_table_association" "private" {
  count          = 3
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

# Create a route for the private subnets to use the NAT gateway
resource "aws_route" "private" {
  count                  = 3
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.test-vpc.id
}

