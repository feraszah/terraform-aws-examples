provider "aws" {
  region     = "${var.region}"
}

# https://www.terraform.io/docs/providers/aws/

resource "aws_vpc" "main" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"

  tags = {
    Name = "main"
    Location = "Virginia"
  }
}

# https://www.terraform.io/docs/providers/aws/r/vpc.html

resource "aws_subnet" "subnets" {
  count = "${length(data.aws_availability_zones.azs.names)}"
  availability_zone = "${element(data.aws_availability_zones.azs.names,count.index)}"
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${element(var.subnet_cidr,count.index)}"

  tags = {
    Name = "Subnet-${count.index+1}"
  }
}

# https://www.terraform.io/docs/providers/aws/r/subnet.html
# https://www.terraform.io/docs/configuration/interpolation.html
