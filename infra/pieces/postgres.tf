resource "helm_release" "pieces-postgres" {
  name       = "pieces-postgres"
  repository = "oci://registry-1.docker.io/bitnamicharts"
  
  #chart     = "bitnami/postgresql"
  chart      = "postgresql"
  version    = "16.5.0"
  repository_username = var.docker_username
  repository_password = var.docker_password

  values = [
    yamlencode({
      image = {
        pullSecrets = ["auth-docker"]
      }

      global = {
        postgresql = {
          #postgresqlPassword = "mysecretpassword"
          #postgresqlDatabase = "mydatabase"
          auth = {
            postgresPassword = "test123"
            #username: "pieces"
            #password: "test123"
            database: "pieces-db"
          }
        }
      }
      primary = {
        service = {
          type     = "NodePort"
          #port     = 5432
          #nodePort = 31111  # Your chosen node port (30000-32767)
          nodePorts = {
            postgresql = "31111"
          }
        }
      }
      persistence = {
        enabled = true
        size    = "8Gi"
        #storageClass  = "standard"
      }
      replicaCount = 1
    })
  ]

}

