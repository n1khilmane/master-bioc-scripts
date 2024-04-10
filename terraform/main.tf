provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "us-east-1"
}

resource "aws_instance" "ec2_instance" {
    ami = "${var.ami_id}"
    count = "${var.number_of_instances}"
    subnet_id = "${var.subnet_id}"
    instance_type = "${var.instance_type}"
    key_name = "${var.ami_key_pair_name}"

    # Editable configurations
    # Add more configurations as needed
    # For example:
    # tags = {
    #   Name = "MyEC2Instance"
    #   Environment = "Production"
    # }

    tags = var.tags
}

resource "aws_volume" "volume1" {
    availability_zone = aws_instance.ec2_instance.availability_zone
    size              = var.volume_size_1
}

resource "aws_volume" "volume2" {
    availability_zone = aws_instance.ec2_instance.availability_zone
    size              = var.volume_size_2
}

resource "aws_volume_attachment" "volume_attachment1" {
    device_name = "/dev/sdf"
    volume_id   = aws_volume.volume1.id
    instance_id = aws_instance.ec2_instance.id
}

resource "aws_volume_attachment" "volume_attachment2" {
    device_name = "/dev/sdg"
    volume_id   = aws_volume.volume2.id
    instance_id = aws_instance.ec2_instance.id
}
