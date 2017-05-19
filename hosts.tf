provider "aws" {
  region     = "${var.aws_region}"
}

resource "aws_instance" "ucp-manager" {
  ami           = "${lookup(var.aws_amis, var.aws_region)}"
  instance_type = "${var.manager_instance_type}"
  key_name      = "${var.key_name}"

  root_block_device {
    volume_type = "gp2"
    delete_on_termination = true
  }

  count = "${var.ucp_manager_count}"

  security_groups = [ "${aws_security_group.ddc.name}" ]
  availability_zone = "${element(split(",", var.availability_zones), count.index) }"

  tags {
    Name = "${var.name_prefix}_ucp-manager${count.index + 1}"
  }
}

resource "aws_instance" "ucp-dtr" {
  ami           = "${lookup(var.aws_amis, var.aws_region)}"
  instance_type = "${var.manager_instance_type}"
  key_name      = "${var.key_name}"

  root_block_device {
    volume_type = "gp2"
    delete_on_termination = true
  }

  count = "${var.ucp_dtr_count}"

  security_groups = [ "${aws_security_group.ddc.name}" ]
  availability_zone = "${element(split(",", var.availability_zones), count.index) }"

  tags {
    Name = "${var.name_prefix}_ucp-dtr${count.index + 1}"
  }
}

resource "aws_instance" "ucp-worker" {
  ami           = "${lookup(var.aws_amis, var.aws_region)}"
  instance_type = "${var.worker_instance_type}"
  key_name      = "${var.key_name}"

  root_block_device {
    volume_type = "gp2"
    delete_on_termination = true
  }

  count = "${var.ucp_worker_count}"

  security_groups = [ "${aws_security_group.ddc.name}" ]
  availability_zone = "${element(split(",", var.availability_zones), count.index) }"

  tags {
    Name = "${var.name_prefix}_ucp-node${count.index + 1}"
  }
}

