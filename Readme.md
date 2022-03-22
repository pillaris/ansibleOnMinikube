
# Okolje za testiranje in učenje orodja ansible.

Okolje sestavljajo 3 nodi
* master: Ubuntu: ima nameščen ansible.
* worker01: Ubuntu 
* worker02: Ubuntu

Pogoji/prerequisite:
* nameščen in zagnan minikube

## Zagon in priprava okolja:

1. zaženi minikube:
`minikube start`

2. zaženi run.sh skripto
`./run.sh`

## Kako uporabljati okolje

1. Poveži se na node: master
`kubectl -n ansible-lab exec -it master -- bash`

2. Na worker nodih je narejen uporabnik: ansy:object00

3. Predloga za inventory:
`
localhost     ansible_connection=local
master        ansible_connection=local
worker01      ansible_user=myuser      ansible_ssh_pass=object00
worker02      ansible_user=myuser      ansible_ssh_pass=object00
`
