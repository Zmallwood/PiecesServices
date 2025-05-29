terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

module "services_submodule" {
  source = "./pieces"

  docker_username = var.docker_username
  docker_password = var.docker_password
  docker_email    = var.docker_email
}
