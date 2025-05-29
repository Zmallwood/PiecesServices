resource "kubernetes_deployment" "pieces-frontend" {
  metadata {
    name = "pieces-frontend"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "pieces-frontend"
      }
    }

    template {
      metadata {
        labels = {
          app = "pieces-frontend"
        }
      }

      spec {
        container {
          name  = "pieces-frontend"
          image = "localhost:5000/pieces-frontend:latest"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "pieces-frontend_service" {
  metadata {
    name = "pieces-frontend-service"
  }

  spec {
    selector = {
      app = kubernetes_deployment.pieces-frontend.spec[0].template[0].metadata[0].labels.app
    }
    port {
      port        = 80
      target_port = 80
    }
    type = "LoadBalancer"  # Or "LoadBalancer" depending on your setup
    load_balancer_ip = "192.168.1.243"
  }
}
