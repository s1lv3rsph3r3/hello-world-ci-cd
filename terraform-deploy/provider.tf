terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.7.0"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 2.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

variable "do_token" {}
variable "pvt_key" {}
variable "pvt_key_file" {}
variable "cloudflare_token" {}
variable "cloudflare_zone_id" {}
variable "aws_region" {}
variable "aws_access_key" {}
variable "aws_secret_key" {}

provider "digitalocean" {
  token = var.do_token
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

data "digitalocean_ssh_key" "enigma-ssh" {
  name = "enigma-ssh"
}

provider "cloudflare" {
  email = "tim.a.rawlins@gmail.com"
  api_key = var.cloudflare_token
}

variable "domain" {
  default = "packetpigeon.com"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "packet-pigeon-console-terraform-state"
  versioning {
    enabled = true
  }
}

resource "cloudflare_record" "packetpigeon" {
  name   = "packetpigeon.com"
  value  = digitalocean_droplet.www-1.ipv4_address
  type = "A"
  proxied = true
  zone_id = var.cloudflare_zone_id
}

resource "cloudflare_record" "www" {
  name    = "www"
  value   = digitalocean_droplet.www-1.ipv4_address
  type    = "A"
  proxied = true
  zone_id = var.cloudflare_zone_id
}

resource "cloudflare_record" "api" {
  name   = "api"
  value  = digitalocean_droplet.www-1.ipv4_address
  type = "A"
  proxied = true
  zone_id = var.cloudflare_zone_id
}

resource "cloudflare_record" "service" {
  name   = "service"
  value  = digitalocean_droplet.www-1.ipv4_address
  type = "A"
  proxied = true
  zone_id = var.cloudflare_zone_id
}

terraform {
  backend "s3" {
    bucket = "packet-pigeon-console-terraform-state"
    key = "default-infrastructure"
    region = "eu-west-1"
    profile = "default"
    encrypt = true
  }
}
