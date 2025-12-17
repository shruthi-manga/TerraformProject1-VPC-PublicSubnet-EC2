provider "aws" {
  region = "us-east-1"
}
##### NETWORK Resources #####
resource "aws_vpc" "my-vpc" {
    cidr_block = "10.0.0.0/16"
  
}
resource "aws_subnet" "public-subnet" {
    vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.0.0/28"

}

#this is to create route table to attach IG

resource "aws_internet_gateway" "my-ig" {
    vpc_id = aws_vpc.my-vpc.id
  
}

#this is to create route table to attach IG
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.my-vpc.id
  
}

resource "aws_route" "IG-rt" {
    route_table_id = aws_route_table.public-rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-ig.id
    
}

resource "aws_route_table_association" "public-subnet-association-to-rt" {
    subnet_id = aws_subnet.public-subnet.id
    route_table_id = aws_route_table.public-rt.id
  
}

### Compute Resources ###

resource "aws_instance" "public-ec2" {
    ami = "ami-020cba7c55df1f615"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public-subnet.id
  
}