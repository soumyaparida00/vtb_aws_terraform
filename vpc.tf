resource "aws_vpc" "vtb-test" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  instance_tenancy = "default"

  tags = {
    Name = "vtb-test"
  }

}
resource "aws_subnet" "vtb-sub-pub-1a" {
    vpc_id = "${aws_vpc.vtb-test.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true" //it makes this a public subnet
    availability_zone = "us-east-1a"
    tags = {
        Name = "vtb-sub-pub-1a"
    }
}
resource "aws_subnet" "vtb-sub-pub-1b" {
    vpc_id = "${aws_vpc.vtb-test.id}"
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "true" //it makes this a public subnet
    availability_zone = "us-east-1b"
    tags = {
        Name = "vtb-sub-pub-1b"
    }
}
resource "aws_subnet" "vtb-sub-pub-1c" {
    vpc_id = "${aws_vpc.vtb-test.id}"
    cidr_block = "10.0.3.0/24"
    map_public_ip_on_launch = "true" //it makes this a public subnet
    availability_zone = "us-east-1c"
    tags = {
        Name = "vtb-sub-pub-1c"
    }
}
resource "aws_subnet" "vtb-sub-pri-1a" {
    vpc_id = "${aws_vpc.vtb-test.id}"
    cidr_block = "10.0.4.0/24"
    map_public_ip_on_launch = "false" //it makes this a public subnet
    availability_zone = "us-east-1a"
    tags = {
        Name = "vtb-sub-pri-1a"
        
    }
}
resource "aws_subnet" "vtb-sub-pri-1b" {
    vpc_id = "${aws_vpc.vtb-test.id}"
    cidr_block = "10.0.5.0/24"
    map_public_ip_on_launch = "false" //it makes this a public subnet
    availability_zone = "us-east-1b"
    tags = {
        Name = "vtb-sub-pri-1b"
    }
}
resource "aws_subnet" "vtb-sub-pri-1c" {
    vpc_id = "${aws_vpc.vtb-test.id}"
    cidr_block = "10.0.6.0/24"
    map_public_ip_on_launch = "false" //it makes this a public subnet
    availability_zone = "us-east-1c"
    tags = {
        Name = "vtb-sub-pri-1c"
    }
}
resource "aws_internet_gateway" "vtb-igw" {
    vpc_id = "${aws_vpc.vtb-test.id}"
    tags = {
        Name = "vtb-igw"
    }
}
resource "aws_route_table" "vtb-pub-crt" {
    vpc_id = "${aws_vpc.vtb-test.id}"
    
    route {
        //associated subnet can reach everywhere
        cidr_block = "0.0.0.0/0" 
        //CRT uses this IGW to reach internet
        gateway_id = "${aws_internet_gateway.vtb-igw.id}" 
    }
    
    tags = {
        Name = "vtb-pub-crt"
    }
}
resource "aws_route_table_association" "vtb-crt-sub-pub-1a"{
    subnet_id = "${aws_subnet.vtb-sub-pub-1a.id}"
    route_table_id = "${aws_route_table.vtb-pub-crt.id}"
}
resource "aws_route_table_association" "vtb-crt-sub-pub-1b"{
    subnet_id = "${aws_subnet.vtb-sub-pub-1b.id}"
    route_table_id = "${aws_route_table.vtb-pub-crt.id}"
}
resource "aws_route_table_association" "vtb-crt-sub-pub-1c"{
    subnet_id = "${aws_subnet.vtb-sub-pub-1c.id}"
    route_table_id = "${aws_route_table.vtb-pub-crt.id}"
}
resource "aws_security_group" "ssh-allowed" {
    vpc_id = "${aws_vpc.vtb-test.id}"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        // This means, all ip address are allowed to ssh ! 
        // Do not do it in the production. 
        // Put your office or home address in it!
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "ssh-allowed"
    }

}

# resource "aws_security_group" "openvpn" {
#     vpc_id = "${aws_vpc.vtb-test.id}"
    
#     egress {
#         from_port = 0
#         to_port = 0
#         protocol = -1
#         cidr_blocks = ["0.0.0.0/0"]
#     }
#     //If you do not add this rule, you can not reach the NGINX  
#     ingress {
#         from_port = 80
#         to_port = 80
#         protocol = "tcp"
#         cidr_blocks = ["0.0.0.0/0"]
#     }
#     ingress {
#         from_port = 443
#         to_port = 443
#         protocol = "tcp"
#         cidr_blocks = ["0.0.0.0/0"]
#     }
#     ingress {
#         from_port = 943
#         to_port = 943
#         protocol = "tcp"
#         cidr_blocks = ["0.0.0.0/0"]
#     }
#     tags = {
#         Name = "openvpn"
#     }
# }