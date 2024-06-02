# Path (A)
# Onboard a Kubernetes Cluster for Discovery 

A key capability of TLS Protect for Kubernetes is the Disocvery of certificates in Kubernetes clusters

First you will seed some data into a cluster then you will onboard this cluster to VaaS for Discovery

If you don't have a Kubernetes cluster already, create one
- [Install Kind](README2.md#kind)
- [Create a Kubernetes cluster](README2.md#kubernetes-cluster)

## Seed data

```shell 
#Self signed cert
./venafi-install/sample-certificates/01.unmanaged-kid.sh

#Cert with bad key size
./venafi-install/sample-certificates/03.cipher-snake.sh
```

| Bandit           | Unmanaged    | Long Expiry | Weak Cipher | Non-Venafi | Unused    |
| ---------------- | ------------ | ----------- | ----------- | ---------- | --------- |
| 1) Lone Outlaw   | YES          | no          | no          | no         | no        |
| 3) Cipher Snake  | no           | no          | YES         | no         | no        |


## Onboard cluster to Venafi Control Plane

Go to Installations > Kubernetes Clusters > Connect

<p align="center">
  <img src="../imgs/16.png" width="800" />
</p>

Click Continue

<p align="center">
  <img src="../imgs/17.png" width="800" />
</p>

Copy the installation command to install `venctl`
If you have `venctl` installed already then skip this step 

<p align="center">
  <img src="../imgs/18.png" width="800" />
</p>

The installation script will guide you through the installation process

<p align="center">
  <img src="../imgs/19.png" width="800" />
</p>

Type in the Kubernetes cluster name as you would like it to show e.g. `tech-training-discovery`

Copy the connect commoand which will also include the api key ready to connect

<p align="center">
  <img src="../imgs/20.png" width="800" />
</p>

Run the connect command in a terminal after you have set the kubernetes context to the cluster you wish to connect to
if you have multiple contexts, you will be prompted to choose the one you would like to connect. You will also be prompted to choose which team 

if you don't have a team already created, please create one [Create a Team](README1.md#create-a-team)

<p align="center">
  <img src="../imgs/21.png" width="800" />
</p>

Go back to the Console, mark the check that the cluster is successfully connected then click Finish

<p align="center">
  <img src="../imgs/22.png" width="800" />
</p>

You should now see your cluster connect. Click *View Certificates* to view discovered certificates. It might take a few moments for more certificates to flow in

<p align="center">
  <img src="../imgs/23.png" width="800" />
</p>



[Main Menu](../README.md)