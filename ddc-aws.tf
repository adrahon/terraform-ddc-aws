provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_security_group" "ddc" {
    name = "ddc-default"
    description = "Default Security Group for Docker Datacenter"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        self = true
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
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

  tags {
    Name = "${var.name_prefix}ucp-manager${count.index + 1}"
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

  tags {
    Name = "${var.name_prefix}ucp-node${count.index + 1}"
  }
}

