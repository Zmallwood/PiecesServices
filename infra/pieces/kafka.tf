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

      replicaCount = 1

      service = {
        type            = "LoadBalancer"
        loadBalancerIP  = "192.168.1.244"  # optional: your LB IP
        port            = 9092
        nodePorts       = { client = 32222 } # if you want nodeport as well
      }

      # Allow plaintext listener (for testing/dev)
      allowPlaintextListener = true

      # Configure listeners & advertised listeners
      kafkaListeners = "PLAINTEXT://:9092,CONTROLLER://:9093"
      kafkaAdvertisedListeners = "PLAINTEXT://localhost:9092"
      kafkaListenerSecurityProtocolMap = "CONTROLLER:PLAINTEXT,PLAINTEXT:PLAINTEXT"
      kafkaProcessRoles = "broker,controller"
      kafkaControllerListenerNames = "CONTROLLER"
      kafkaControllerQuorumVoters = "1@localhost:9093"
      kafkaNodeId = 1

      persistence = {
        enabled = true
        size    = "8Gi"
        # storageClass = "standard"
      }
    })
  ]
}

