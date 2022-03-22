#!/bin/bash

# If any command fails -> exit
set -e

# Create namespace -> eazyer to clear the env, just run: kubectl delete ns ansible-lab
kubectl create ns ansible-lab

kubectl -n ansible-lab run master --image=ubuntu --restart=Never --env="DEBIAN_FRONTEND=noninteractive" --env="TZ=Europe/Ljubljana" --command sleep 1d
sleep 10
kubectl -n ansible-lab exec -it master -- bash -c "apt update && apt install -y net-tools ansible sshpass iproute2 vim openssh-server openssh-client"
kubectl -n ansible-lab exec -it master -- bash -c "service ssh start"
kubectl -n ansible-lab exec -it master -- bash -c "useradd -m -s /bin/bash -p $(echo object00 | openssl passwd -1 -stdin) ansy"

kubectl -n ansible-lab run worker01 --image=ubuntu --restart=Never --env="DEBIAN_FRONTEND=noninteractive" --env="TZ=Europe/Ljubljana" --command sleep 1d
sleep 10
kubectl -n ansible-lab exec -it worker01 -- bash -c "apt update && apt install -y openssh-server openssh-client && service ssh start"
kubectl -n ansible-lab exec -it worker01 -- bash -c "useradd -m -s /bin/bash ansy && echo 'ansy:object00' | chpasswd"
kubectl -n ansible-lab expose pod worker01 --port 22

kubectl -n ansible-lab run worker02 --image=ubuntu --restart=Never --env="DEBIAN_FRONTEND=noninteractive" --env="TZ=Europe/Ljubljana" --command sleep 1d
sleep 10
kubectl -n ansible-lab exec -it worker02 -- bash -c "apt update && apt install -y openssh-server openssh-client && service ssh start"
kubectl -n ansible-lab exec -it worker02 -- bash -c "useradd -m -s /bin/bash ansy && echo 'ansy:object00' | chpasswd"
kubectl -n ansible-lab expose pod worker02 --port 22

set +e
