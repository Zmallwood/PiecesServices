# PiecesServices

Due to how opentofu/microk8s works, need to serve the services in the NodePort range (30000+)

alternative way to host frontend:
change from NodePort to LoadBalancer
add below LoadBalancer:
load_balancer_ip = "192.168.1.243"

microk8s enable metallb
enter ip range: 192.168.1.240-192.168.1.250

can double check ip with:
microk8s kubectl get svc

can add ip as domain in /etc/hosts, i.e.
192.168.1.243 pieces.local

Then frontend can be accessed at http://pieces.local:80

Note:
redir :9092 192.168.1.244:9092
