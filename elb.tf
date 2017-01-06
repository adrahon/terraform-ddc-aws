resource "aws_elb" "ucp" {
    name = "${var.name_prefix}-ucp"
    security_groups = [
        "${aws_security_group.elb.id}",
    ]
    availability_zones = ["${split(",", var.availability_zones)}"]

    listener {
        instance_port = 443
        instance_protocol = "tcp"
        lb_port = 443
        lb_protocol = "tcp"
    }

    health_check {
        healthy_threshold = 2
        unhealthy_threshold = 10
        timeout = 5
        target = "TCP:443"
        interval = 30
    }

    instances = ["${aws_instance.ucp-manager.*.id}"]
    cross_zone_load_balancing = true
}

resource "aws_elb" "apps" {
    name = "${var.name_prefix}-apps"
    security_groups = [
        "${aws_security_group.apps.id}",
    ]
    availability_zones = ["${split(",", var.availability_zones)}"]

    listener {
        instance_port = 443
        instance_protocol = "tcp"
        lb_port = 443
        lb_protocol = "tcp"
    }

    health_check {
        healthy_threshold = 2
        unhealthy_threshold = 10
        timeout = 5
        target = "TCP:443"
        interval = 30
    }

    instances = ["${aws_instance.ucp-worker.*.id}"]
    cross_zone_load_balancing = true
}

