resource "kubernetes_pod" "pieces-game-renderer" {
  metadata {
    name = "pieces-game-renderer"
    labels = {
      app = "game-renderer"
    }
  }

  spec {
    container {
      name  = "pieces-game-renderer"
      image = "localhost:5000/pieces-game-renderer:latest"

      port {
        container_port = 3001
      }
    }
  }
}

resource "kubernetes_service" "pieces-game-renderer_service" {
  metadata {
    name = "pieces-game-renderer-service"
  }
  spec {
    selector = {
      app = kubernetes_pod.pieces-game-renderer.metadata[0].labels.app
    }
    port {
      port        = 3001
      target_port = 3001
      #  node_port   = 31001  # Must be within NodePort range (30000-32767)
    }
    type = "ClusterIP"
    #type = "NodePort"
  }
}

