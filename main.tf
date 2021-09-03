provider "aws" {
    region = "us-east-2"
#aws configure command
}

variable "cidr_blocks" {
    description = "cidr block for vpc and subnets"
    default = [
        {cidr_block = "10.0.0.0/16", name = "dev-vpc"},
        {cidr_block = "10.0.10.0/24", name = "dev-subnet-1"}
    ]
    type = list(object({
        cidr_block = string
        name = string
    }))
}

variable "avail_zone" {} #set TF_VAR_avail_zone="us-east-2a"
resource "aws_vpc" "dev-vpc" {
    cidr_block = var.cidr_blocks[0].cidr_block
    tags = {
      "Name" = var.cidr_blocks[0].name
    }
}

resource "aws_subnet" "dev-subnet-1" {
    vpc_id = aws_vpc.dev-vpc.id
    cidr_block = var.cidr_blocks[1].cidr_block
    availability_zone = var.avail_zone
    tags = {
      "Name" = var.cidr_blocks[1].name
    }
}

output "dev-vpc-id" {
    value = aws_vpc.dev-vpc.id
}

output "dev-subnet-id" {
    value = aws_subnet.dev-subnet-1.id
}