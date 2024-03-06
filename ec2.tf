resource "aws_instance" "instance_name" {
    # Replace with ami-id with the ami id needs to be used
    ami = "ami-08c40ec9ead489470"
    instance_type = "t2.micro"
    # VPC
    subnet_id = "${aws_subnet.vtb-sub-pub-1a.id}"
    # Security Group
    vpc_security_group_ids = [
        "${aws_security_group.ssh-allowed.id}"
        ]
    # the Public SSH key
    key_name = "id_rsa"
    connection {
        type        = "ssh"
        host        = self.public_ip
        user        = "ubuntu"
        private_key = file("./id_rsa")
        timeout     = "4m"
    }
    tags = {
        Name = "test_server"
    }
}
// Sends your public key to the instance
resource "aws_key_pair" "id_rsa" {
    key_name = "id_rsa"
    public_key = file("./id_rsa.pub")

    tags = {
        Name = "test_server"
    }
}