#!/bin/bash

kubectl run master --image=ubuntu --command sleep 1d
sleep 10
#kubectl exec -it master -- bash -c "echo nameserver 8.8.8.8 >> /etc/resolv.conf"
kubectl exec -it master -- bash -c "apt update && apt install -y net-tools ansible sshpass iproute2 vim openssh-server openssh-client"
kubectl exec -it master -- bash -c "service ssh start"
kubectl exec -it master -- bash -c "useradd -m -s /bin/bash -p $(echo object00 | openssl passwd -1 -stdin) ansy"

kubectl run worker01 --image=ubuntu --command sleep 1d
sleep 10
#kubectl exec -it worker01 -- bash -c "echo nameserver 8.8.8.8 >> /etc/resolv.conf"
kubectl exec -it worker01 -- bash -c "apt update && apt install -y openssh-server openssh-client && service ssh start"
kubectl exec -it worker01 -- bash -c "useradd -m -s /bin/bash -p $(echo object00 | openssl passwd -1 -stdin) ansy"
kubectl  expose pod worker01  --port 22

kubectl run worker02 --image=ubuntu --command sleep 1d
sleep 10
#kubectl exec -it worker02 -- bash -c "echo nameserver 8.8.8.8 >> /etc/resolv.conf"
kubectl exec -it worker02 -- bash -c "apt update && apt install -y openssh-server openssh-client && service ssh start"
kubectl exec -it worker02 -- bash -c "useradd -m -s /bin/bash -p $(echo object00 | openssl passwd -1 -stdin) ansy"
kubectl  expose pod worker02  --port 22
