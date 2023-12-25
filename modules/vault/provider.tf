terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.12.1"
    }

    vault = {
      source  = "hashicorp/vault"
      version = "3.7.0"
    }
  }
}

