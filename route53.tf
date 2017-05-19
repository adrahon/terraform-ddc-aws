resource "aws_route53_zone" "ddc" {
  name = "${var.domainname}"
  comment = "${var.name_prefix} DDC zone"
}

resource "aws_route53_record" "ddc-ns" {
    zone_id = "${aws_route53_zone.ddc.zone_id}"
    name = "${var.domainname}"
    type = "NS"
    ttl = "30"
    records = [
        "${aws_route53_zone.ddc.name_servers.0}",
        "${aws_route53_zone.ddc.name_servers.1}",
        "${aws_route53_zone.ddc.name_servers.2}",
        "${aws_route53_zone.ddc.name_servers.3}"
    ]
}

resource "aws_route53_record" "ucp" {
  zone_id = "${aws_route53_zone.ddc.zone_id}"
  name = "${var.ucp_dns}.${var.domainname}."
  type = "CNAME"
  ttl = "300"
  records = ["${aws_elb.ucp.dns_name}"]
}

resource "aws_route53_record" "dtr" {
  zone_id = "${aws_route53_zone.ddc.zone_id}"
  name = "${var.dtr_dns}.${var.domainname}."
  type = "CNAME"
  ttl = "300"
  records = ["${aws_elb.dtr.dns_name}"]
}

resource "aws_route53_record" "apps" {
  zone_id = "${aws_route53_zone.ddc.zone_id}"
  name = "*.${var.apps_dns}.${var.domainname}."
  type = "CNAME"
  ttl = "300"
  records = ["${aws_elb.apps.dns_name}"]
}

resource "aws_route53_record" "ucp-manager" {
  count = "${var.ucp_manager_count}"
  zone_id = "${aws_route53_zone.ddc.zone_id}"
  name = "ucp-manager${count.index + 1}.${var.domainname}"
  type = "A"
  ttl = "300"
  records = ["${element(aws_instance.ucp-manager.*.public_ip, count.index)}"]
}

resource "aws_route53_record" "ucp-worker" {
  count = "${var.ucp_worker_count}"
  zone_id = "${aws_route53_zone.ddc.zone_id}"
  name = "ucp-worker${count.index + 1}.${var.domainname}"
  type = "A"
  ttl = "300"
  records = ["${element(aws_instance.ucp-worker.*.public_ip, count.index)}"]
}

