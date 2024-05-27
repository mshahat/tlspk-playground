# Deploy Components to a Kubernetes Cluster

In this stage of the setup, you will work on deploying the required components to a kubernetes cluster

You will need the following tools on the workstation 

- Venafi CLI venctl
- Kind

Go runtime, docker and Kubectl are already installed on Codespace


## Venafi CLI

Install `venctl`. It will be used to depoloy the components to your cluster and also onbnoard the cluster to Venafi Control Plane for Discovery

```
sudo curl -sSfL https://dl.venafi.cloud/venctl/latest/installer.sh | bash
```

```bash
# check venctl installed
venctl version
```

[Instal Venafi CLI](https://docs.venafi.cloud/vaas/venctl/t-venctl-install/)

## Kind

Install Kind. It will be used to run local kubernetes clusters. For more learning experience and outside of this workshop, try to achieve the same using other flavours of Kubernetes. The simplest is to run a kubernetes cluster on a cloud provider of choice. 

```bash
go install sigs.k8s.io/kind@v0.23.0
```

```bash
# check if kind is installed as expected
kind --version
```

## Kubernetes cluster

Use Kind to create a kubernetes cluster 

```
kind create cluster --name tech-training
```

```bash
# check if cluster 
kind get clusters 
kubectl cluster-info
```

`K9s` is a useful terminal based kubernetes viewer. You can install it as following, *run it in a seperate terminal window*

```bash
# install k9s
go install github.com/derailed/k9s@latest
# run k8s without the header to save space
k9s --headless
```

## Create kubernetes pull secret

Remember the service account you created in the previous stage. This is when you use it to create a pull secret resource in kubernetes in `venafi` namespace

```bash
kubectl create namespace venafi

kubectl apply --namespace=venafi -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: venafi-image-pull-secret
data:
  .dockerconfigjson: xxxxxxxxxxxxxxxxxxxxxxxxxxxxx
type: kubernetes.io/dockerconfigjson
EOF
```


## Generate manifest

In this step, you will use `venctl` to generate a manifest that will be used to deploy the components of interest to the kubernetes

Components needed to issue certificates are to be deployed. There are more components for more usecases that are out of scope for this workshop 

Use `venctl` to generate the manifest required to deploy

```bash
mkdir venafi-install
```

```bash
venctl components kubernetes manifest generate \
        --namespace venafi \
        --approver-policy-enterprise \
        --trust-manager \
        --venafi-connection \
        --venafi-enhanced-issuer \
        --image-pull-secret-names venafi-image-pull-secret > venafi-install/venafi-manifests.yaml
```

open the `venafi-install/venafi-manifests.yaml` and orient yourself with its content



## Deploy

There are multiple approaches that our customers could use to deploy these components. In this occassion we will use `venctl` capability to deploy the components using the `sync` command. It assumes the right kubernetes context is set for your `kubectl`

```
venctl components kubernetes manifest tool sync --file venafi-install/venafi-manifests.yaml
```


```bash
UPDATED RELEASES:
NAME                         NAMESPACE   CHART                                      VERSION   DURATION
venafi-connection            venafi      venafi-charts/venafi-connection            v0.1.0          2s
cert-manager                 venafi      venafi-charts/cert-manager                 v1.14.5      1m51s
cert-manager-csi-driver      venafi      venafi-charts/cert-manager-csi-driver      v0.8.1          3s
venafi-enhanced-issuer       venafi      venafi-charts/venafi-enhanced-issuer       v0.14.0        23s
approver-policy-enterprise   venafi      venafi-charts/approver-policy-enterprise   v0.17.0        23s
trust-manager                venafi      venafi-charts/trust-manager                v0.10.0        17 
```



https://aka.ms/ghcs-default-image

https://aka.ms/configure-codespace

[Main Menu](../README.md) | Next [Create a Cert Manager Issuer](README3.md)