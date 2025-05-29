resource "kubernetes_deployment" "pieces-postgres" {
  metadata {
    name = "pieces-postgres"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "pieces-postgres"
      }
    }

    template {
      metadata {
        labels = {
          app = "pieces-postgres"
        }
      }

      spec {
        container {
          name  = "postgres"
          image = "public.ecr.aws/bitnami/postgresql:latest"

          env {
            name  = "POSTGRESQL_PASSWORD"
            value = "test123"
          }

          env {
            name = "POSTGRES_DB"
            value = "pieces_db"
          }

          port {
            container_port = 5432
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "pieces-postgres_service" {
  metadata {
    name = "pieces-postgres-service"
  }

  spec {
    selector = {
      app = kubernetes_deployment.pieces-postgres.spec[0].template[0].metadata[0].labels.app
    }
    port {
      port        = 5432
      target_port = 5432
      node_port   = 31111
    }
    #type = "ClusterIP"
    type = "NodePort"
  }
}
