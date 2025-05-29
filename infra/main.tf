provider "kubernetes" {
  config_path = "~/.kube/config"
}

module "services_submodule" {
  source = "./services"
}
