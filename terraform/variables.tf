variable "access_key" {
    description = "Access key to AWS console"
}
variable "secret_key" {
    description = "Secret key to AWS console"
}

variable "instance_name" {
    description = "Name of the instance to be created"
    default = "master-bioc-test"
}

variable "instance_type" {
    default = "t2.micro"
}

variable "subnet_id" {
    description = "The VPC subnet the instance(s) will be created in"
    default = "subnet-07ebbe60"
}

variable "ami_id" {
    description = "The AMI to use"
    default = "ami-09d56f8956ab235b3"
}

variable "number_of_instances" {
    description = "number of instances to be created"
    default = 1
}

variable "ami_key_pair_name" {
    default = "tomcat"
}

variable "tags" {
    description = "Additional tags for the EC2 instance"
    type = map(string)
    default = {
        Name = var.instance_name
        Environment = "Production"
    }
}

variable "volume_size_1" {
    description = "Size of the first volume in GB"
    default     = 100
}

variable "volume_size_2" {
    description = "Size of the second volume in GB"
    default     = 500
}