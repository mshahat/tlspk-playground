# Onboard a Kubernetes Cluster for Discovery

## Seed data

```shell 
#Self signed cert
./venafi-install/sample-certificates/01.unmanaged-kid.sh

#Cert with long duration mounted on a pod
kubectl apply -f ./venafi-install/sample-certificates/02-expiry-eddie-cert.yaml
./venafi-install/sample-certificates/02.expiry-eddie.sh

#Cert with bad key size
./venafi-install/sample-certificates/03.cipher-snake.sh

#Orphan cert
kubectl apply -f venafi-install/sample-certificates/04-ghost-rider-cert.yaml

#phanton ca and cert
kubectl apply -f venafi-install/sample-certificates/cert-policy-and-rbac-self-signed.yaml 
kubectl apply -f venafi-install/sample-certificates/05-phantom-ca-cert.yaml
./venafi-install/sample-certificates/05.phantom-ca.sh
```


| Bandit           | Unmanaged    | Long Expiry | Weak Cipher | Non-Venafi | Unused    |
| ---------------- | ------------ | ----------- | ----------- | ---------- | --------- |
| 1) Lone Outlaw   | YES          | no          | no          | no         | no        |
| 2) Time Bandit   | no           | YES         | no          | no         | no        |
| 3) Cipher Snake  | no           | no          | YES         | no         | no        |
| 4) Ghost Rider   | no           | no          | no          | no         | YES       |
| 5) Phantom CA    | no           | no          | no          | YES        | no        |



## Onboard cluster to Venafi Control Plane





[Main Menu](../README.md)