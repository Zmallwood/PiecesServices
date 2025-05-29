resource "kubernetes_pod" "pieces-main-api" {
  metadata {
    name = "pieces-main-api"
    labels = {
      app = "main-api"
    }
  }

  spec {
    container {
      name  = "pieces-main-api"
      image = "localhost:5000/pieces-main-api:latest"

      port {
        container_port = 3000
      }
    }
  }
}

resource "kubernetes_service" "pieces-main-api_service" {
  metadata {
    name = "pieces-main-api-service"
  }
  spec {
    selector = {
      app = kubernetes_pod.pieces-main-api.metadata[0].labels.app
    }
    port {
      port        = 3000
      target_port = 3000
      node_port   = 31000  # Must be within NodePort range (30000-32767)
    }
    type = "NodePort"
  }
}
