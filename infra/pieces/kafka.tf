resource "helm_release" "pieces_kafka" {
  name       = "pieces-kafka"
  #repository = "https://charts.bitnami.com/bitnami"
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "kafka"
  version    = "32.2.10"  # choose a stable version
  repository_username = var.docker_username
  repository_password = var.docker_password

  values = [
    yamlencode({
      image = {
        pullSecrets = ["auth-docker"]
      }

defaultInitContainers = {
        autoDiscovery = {
        enabled=true
        }
      }

      kafka = {
  kafkaProcessRoles = "controller"
  kafkaControllerListenerNames = "CONTROLLER"
  kafkaListeners = "CONTROLLER://:9093"
      }

      controller = {
        automountServiceAccountToken = true

        controllerOnly = true
        #readinessProbe = {
        #  enabled = false
        #}
      }
      
        broker = {
        automountServiceAccountToken = true

      }

      enabled = true

      broker = {
  replicaCount = 1
        automountServiceAccountToken = true

        readinessProbe = {
          enabled = false
        }
}

    externalAccess = {
      enabled = true
      service = {
        type   = "NodePort"
        domain = "localhost"
      }
      autoDiscovery = {
        enabled = true
      }
broker = {
    service = {
      type       = "NodePort"
        domain = "localhost"
      nodePorts  = [32222]  # One for each broker
      useHostIPs = true
    }

        readinessProbe = {
          enabled = false
        }
  }

    }

    serviceAccount = {
      create = true
    }

    rbac = {
      create = true
    }


      # Allow plaintext listener (for testing/dev)
      allowPlaintextListener = true

      listeners = {
  #client:
  #  protocol: 'PLAINTEXT'
  controller= {
    protocol= "PLAINTEXT"
        }
  #external:
  #  protocol: 'PLAINTEXT'
        #advertisedListeners: "PLAINTEXT://localhost:32222"
  advertisedListeners: "PLAINTEXT://localhost:32222"
      }

      #listeners = {
      #  client = {
      #    protocol = "PLAINTEXT"
      #  }
      #}

      #auth = {
      #  clientProtocol = "plaintext"
      #  interBrokerProtocol = "plaintext"
      #}

      ## Configure listeners & advertised listeners
      #kafkaListeners = "PLAINTEXT://:9092,CONTROLLER://:9093"
      ##kafkaAdvertisedListeners = "PLAINTEXT://localhost:9092"
      #kafkaAdvertisedListeners = "PLAINTEXT://192.168.1.244:32222"
      #kafkaListenerSecurityProtocolMap = "CONTROLLER:PLAINTEXT,PLAINTEXT:PLAINTEXT"
      #kafkaProcessRoles = "broker,controller"
      #kafkaControllerListenerNames = "CONTROLLER"
      #kafkaControllerQuorumVoters = "1@localhost:9093"
      #kafkaNodeId = 1

      persistence = {
        enabled = true
        size    = "8Gi"
        # storageClass = "standard"
      }
    })
  ]
}

