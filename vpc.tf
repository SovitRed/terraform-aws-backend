#############    Create VPC  ###########################

resource "aws_vpc" "vpc" {
  cidr_block = var.aws_vpc_cidr
  enable_dns_support = var.enable_dns_support           #gives you an internal domain name
  enable_dns_hostnames = var.enable_dns_hostnames       #gives you an internal host name
  instance_tenancy = var.instance_tenancy 

  tags = {
    Name = "${var.prefix}-${var.environment}-vpc"
  }
}

#############    create subnet  ####################

resource "aws_subnet" "public_subnet-1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet-1_cidr
  availability_zone = var.public_subnet_availability_zone-1

  tags = {
    Name = "${var.prefix}-pub-subnet-1"
  }
}

resource "aws_subnet" "public_subnet-2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet-2_cidr
  availability_zone = var.public_subnet_availability_zone-2

  tags = {
    Name = "${var.prefix}-pub-subnet-2"
  }
}

resource "aws_subnet" "private_subnet-1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet-1_cidr
  availability_zone = var.private_subnet_availability_zone-1

  tags = {
    "Name" = "${var.prefix}-pvt-subnet-1"
  }
}

resource "aws_subnet" "private_subnet-2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet-2_cidr
  availability_zone = var.private_subnet_availability_zone-2

  tags = {
    "Name" = "${var.prefix}-pvt-subnet-2"
  }
}


##################     Internet Gateway ########################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    "Name" = "${var.prefix}-igw"
  }
}

####################     Elastic IP   #########################

resource "aws_eip" "nat_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.igw]
}

###############        NAT Gateway  ##################

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet-1.id

  tags = {
    "Name" = "${var.prefix}-nat-gatway"
  }
}

##############       public_RT  ####################333333

resource "aws_route_table" "public_RT" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.rt_cidr
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    "Name" = "${var.prefix}-pub-RT"
  }
}

#######  Associate public-RT  ############################

resource "aws_route_table_association" "public_RT-1" {
  subnet_id      = aws_subnet.public_subnet-1.id
  route_table_id = aws_route_table.public_RT.id
}

resource "aws_route_table_association" "public_RT-2" {
  subnet_id      = aws_subnet.public_subnet-2.id
  route_table_id = aws_route_table.public_RT.id
}

#######     private_RT  ###########################

resource "aws_route_table" "private_RT" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = var.rt_cidr
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    "Name" = "${var.prefix}-pvt-RT"
  }
}

#############  Association private-RT  #############################

resource "aws_route_table_association" "private_RT-1" {
  subnet_id      = aws_subnet.private_subnet-1.id
  route_table_id = aws_route_table.private_RT.id
}

resource "aws_route_table_association" "private_RT-2" {
  subnet_id      = aws_subnet.private_subnet-2.id
  route_table_id = aws_route_table.private_RT.id
}


###############   Database Subnet  ##########################

resource "aws_db_subnet_group" "db_subnet" {
  name                   = "${var.prefix}-db-subnet"
  subnet_ids            =  [aws_subnet.private_subnet-1.id, aws_subnet.private_subnet-2.id]

  tags                  =  {
    "Name"              =  "${var.prefix}-db"
  }
}