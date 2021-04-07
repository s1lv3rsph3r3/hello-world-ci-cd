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
  }
}

variable "do_token" {}
variable "pvt_key" {}
variable "pvt_key_file" {}
variable "cloudflare_token" {}
variable "cloudflare_zone_id" {}

provider "digitalocean" {
  token = var.do_token
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

resource "cloudflare_record" "packetpigeon" {
  domain = var.domain
  name   = "packetpigeon.com"
  value  = digitalocean_droplet.www-1.ipv4_address
  type = "A"
  proxied = true
  zone_id = var.cloudflare_zone_id
}

resource "cloudflare_record" "www" {
  domain  = var.domain
  name    = "www"
  value   = digitalocean_droplet.www-1.ipv4_address
  type    = "A"
  proxied = true
  zone_id = var.cloudflare_zone_id
}

resource "cloudflare_record" "api" {
  domain = var.domain
  name   = "api"
  value  = digitalocean_droplet.www-1.ipv4_address
  type = "A"
  proxied = true
  zone_id = var.cloudflare_zone_id
}

resource "cloudflare_record" "service" {
  domain = var.domain
  name   = "service"
  value  = digitalocean_droplet.www-1.ipv4_address
  type = "A"
  proxied = true
  zone_id = var.cloudflare_zone_id
}
