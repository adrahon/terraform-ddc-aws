# terraform-ddc-aws

Terraform scripts to build a Docker Datacenter cluster on AWS

Currently provides:
 - a security group
 - Centos 7 instances for managers and workers

## Usage

The scripts use default credentials management for AWS, most likely in `~/.aws/credentials`, see the [Terraform docs](https://www.terraform.io/docs/providers/aws/index.html) or this [AWS blog post](https://aws.amazon.com/blogs/apn/terraform-beyond-the-basics-with-aws/) for more details

You need to define the following variables:
 - `aws_region`: defaults to `us-east-1`
 - `key_name`: the name of an existing key-pair
 - `public_key`: the public key

There are more variables you can define, look in [variables.tf](variables.tf)

After `terraform apply`, get `terraform output` will give you the info needed to feed <https://github.com/adrahon/ansible-docker-ucp>

## Customization

The easiest way to change some of the parameters is to add a `override.tf` file. For example, to change the AMI used it would have this content:

```
resource "aws_instance" "ucp-manager" {
  ami           = "ami-e8f9f28e"
}

resource "aws_instance" "ucp-dtr" {
  ami           = "ami-e8f9f28e"
}

resource "aws_instance" "ucp-worker" {
  ami           = "ami-e8f9f28e"
}

```
