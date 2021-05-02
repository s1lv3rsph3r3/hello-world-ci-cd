locals {
  deploying_env = {
    blue = {
      blue = {
        server_up = {
          server = true
          dns = false
        }
        dns_up = {
          server = true
          dns = true
        }
        dns_down = {
          server = true
          dns = true
        }
        server_down = {
          server = true
          dns = true
        }
      }
      green = {
        server_up = {
          server = true
          dns = true
        }
        dns_up = {
          server = true
          dns = true
        }
        dns_down = {
          server = true
          dns = false
        }
        server_down = {
          server = false
          dns = false
        }
      }
    }
    green = {
      blue = {
        server_up = {
          server = true
          dns = true
        }
        dns_up = {
          server = true
          dns = true
        }
        dns_down = {
          server = true
          dns = false
        }
        server_down = {
          server = false
          dns = false
        }
      }
      green = {
        server_up = {
          server = true
          dns = false
        }
        dns_up = {
          server = true
          dns = true
        }
        dns_down = {
          server = true
          dns = true
        }
        server_down = {
          server = true
          dns = true
        }
      }
    }
  }
}

variable "deployment_environment" {
  description = "Levels of traffic distribution"
  type        = string
}

variable "deployment_stage" {
  description = "State at which the blue green deployment is at"
  type = string
}
