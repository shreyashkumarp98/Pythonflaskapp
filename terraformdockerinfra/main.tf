terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.16.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "targetserver" {
  name         = "nishanthkp/targetserver:ubuntu16"
  keep_locally = false
}

resource "docker_container" "web_server2" {
  image = docker_image.targetserver.name
  name  = "web_server2"
  ports {
    internal = 5000
    external =  8082
  }
}

resource "docker_container" "db_server2" {
  image = docker_image.targetserver.name
  name  = "db_server2"
  ports {
    internal = 3306
    external = 3306
  }
}

output "ips1" {
    value = docker_container.web_server2.ip_address
}

output "ips2" {
    value = docker_container.db_server2.ip_address
}
