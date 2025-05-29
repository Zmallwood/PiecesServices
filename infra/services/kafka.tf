resource "kubernetes_deployment" "pieces-kafka" {
  metadata {
    name = "pieces-kafka"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "pieces-kafka"
      }
    }

    template {
      metadata {
        labels = {
          app = "pieces-kafka"
        }
      }

      spec {
        container {
          name  = "kafka"
          image = "public.ecr.aws/bitnami/kafka:latest"

          env {
            name  = "KAFKA_CFG_NODE_ID"
            value = "1"
          }

          env {
            name  = "KAFKA_CFG_PROCESS_ROLES"
            value = "broker,controller"
          }

          env {
            name  = "KAFKA_CFG_CONTROLLER_LISTENER_NAMES"
            value = "CONTROLLER"
          }

          env {
            name  = "KAFKA_CFG_LISTENER_SECURITY_PROTOCOL_MAP"
            value = "CONTROLLER:PLAINTEXT,PLAINTEXT:PLAINTEXT"
          }

          env {
            name  = "KAFKA_CFG_LISTENERS"
            value = "PLAINTEXT://:9092,CONTROLLER://:9093"
          }

          env {
            name  = "KAFKA_CFG_ADVERTISED_LISTENERS"
            #value = "PLAINTEXT://192.168.1.244:9092"
            value = "PLAINTEXT://localhost:9092"
            #value = "PLAINTEXT://192.168.1.140:9092"
          }

          env {
            name  = "ALLOW_PLAINTEXT_LISTENER"
            value = "yes"
          }

          env {
            name  = "KAFKA_CFG_CONTROLLER_QUORUM_VOTERS"
            value = "1@localhost:9093"
          }

          port {
            container_port = 9092
          }

          port {
            container_port = 9093
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "pieces-kafka_service" {
  metadata {
    name = "pieces-kafka-service"
  }

  spec {
    selector = {
      app = kubernetes_deployment.pieces-kafka.spec[0].template[0].metadata[0].labels.app
    }
    port {
      port        = 9092
      target_port = 9092
      #node_port   = 32222
    }
    #type = "ClusterIP"
    #type = "NodePort"
    type = "LoadBalancer"
    load_balancer_ip = "192.168.1.244"
  }
}

