# PiecesServices

to host frontend:
microk8s enable metallb
enter ip range: 192.168.1.240-192.168.1.250

can double check ip with:
microk8s kubectl get svc

can add ip as domain in /etc/hosts, i.e.
192.168.1.243 pieces.local

Then frontend can be accessed at http://pieces.local:80
