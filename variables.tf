variable "access_key" {}
variable "secret_key" {}
variable "key_name" {}
variable "public_key" {}
variable "aws_region" {
  default = "us-east-1"
}
variable "availability_zones" {
  default = "us-east-1a,us-east-1b,us-east-1d"
}
variable "aws_amis" {
  type = "map"
  default = {
    us-east-1      = "ami-6d1c2007" # US East (N. Virginia)
    us-west-1      = "ami-af4333cf" # US West (N. California)
    us-west-2      = "ami-d2c924b2" # US West (Oregon)
    ap-south-1     = "ami-95cda6fa" # Asia Pacific (Mumbai)
    ap-northeast-2 = "ami-c74789a9" # Asia Pacific (Seoul)
    ap-southeast-1 = "ami-f068a193" # Asia Pacific (Singapore)
    ap-southeast-2 = "ami-fedafc9d" # Asia Pacific (Sydney)
    ap-northeast-1 = "ami-eec1c380" # Asia Pacific (Tokyo)
    eu-central-1   = "ami-9bf712f4" # EU (Frankfurt)
    eu-west-1      = "ami-7abd0209" # EU (Ireland)
    sa-east-1      = "ami-26b93b4a" # South America (São Paulo) 
  }
}
variable "ucp_manager_count" {
  description = "Number of manager nodes, needs to be 3, 5 or 7"
  default = 3
}
variable "ucp_worker_count" {
  description = "Number of worker nodes"
  default = 1
}
variable "manager_instance_type" {
  default = "m3.medium"
}
variable "worker_instance_type" {
  default = "m3.medium"
}
variable "name_prefix" {
  default = "test"
}
variable "zone_name" {
  default = "example.com"
}
variable "ucp_dns" {
  default = "ucp"
}
variable "dtr_dns" {
  default = "dtr"
}
variable "apps_dns" {
  default = "apps"
}
