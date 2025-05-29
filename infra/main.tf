provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_pod" "example" {
  metadata {
    name = "nginx"
    labels = {
      app = "nginx"
    }
  }

  spec {
    container {
      name  = "nginx"
      image = "nginx:1.21"
      port {
        container_port = 80
      }
    }
  }
}
