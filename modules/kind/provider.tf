terraform {
  required_providers {
    kind = {
      source  = "justenwalker/kind"
      version = "0.17.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}
