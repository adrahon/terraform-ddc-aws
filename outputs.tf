output "region" {
  value = "${var.aws_region}"
}

output "ucp-primary" {
  value = "${element(aws_instance.ucp-manager.*.public_dns,0)}"
}

output "ucp-managers" {
  value = ["${aws_instance.ucp-manager.*.public_dns}"]
}

output "ucp-dtr" {
  value = ["${aws_instance.ucp-dtr.*.public_dns}"]
}

output "ucp-workers" {
  value = ["${aws_instance.ucp-worker.*.public_dns}"]
}



