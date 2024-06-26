# (Optional) Create certificate examples of common mistakes

This is an optional step creating some sample certificates that highlight common mistakes.
```
wget https://raw.githubusercontent.com/mshahat/tlspk-playground/main/venafi-install/sample-certificates/gen_democerts.sh
chmod +x gen_democerts.sh
./gen_democerts.sh 3 5 7 6 5 12 2 1 2 5 4
```

# Issue Certificates in Kubernetes (the right way)

Now every thing ready to issue certificates in kuberntes using the cluster issuer created earlier

## Sample Certificate via cert-manager

At this stage you will issue a certificate using the builtin ca that comes with Venafi Control Plane. This is configured by the issuing pokicy used

Create `sample-cert1.yaml` under folder `venafi-install`

```yaml
---
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: sample-cert1.venafi.com
  namespace: venafi
spec:
  secretName: sample-cert1.venafi.com
  duration: 24h
  privateKey:
    rotationPolicy: Always
  dnsNames:
    - sample-cert1.venafi.com
  commonName: sample-cert1.venafi.com
  issuerRef:
    name: "venafi-privateca-cluster-issuer"
    kind: "VenafiClusterIssuer"
    group: "jetstack.io"
--- 
```

Create the sample certificate

```bash
kubectl -n venafi apply -f venafi-install/sample-cert1.yaml 
certificate.cert-manager.io/sample-cert1.venafi.com created
```

Now check the certificate request, the certificate and the created tls secret 

```bash
$ kubectl -n venafi get certificaterequest
certificaterequestpolicies.policy.cert-manager.io  certificaterequests.cert-manager.io                

$ kubectl -n venafi get certificaterequest
NAME                        APPROVED   DENIED   READY   ISSUER                            REQUESTOR                                   AGE
sample-cert1.venafi.com-1   True                True    venafi-privateca-cluster-issuer   system:serviceaccount:venafi:cert-manager   33s
trust-manager-1             True                True    trust-manager                     system:serviceaccount:venafi:cert-manager   161m

$ kubectl -n venafi get certificate
NAME                      READY   SECRET                    AGE
sample-cert1.venafi.com   True    sample-cert1.venafi.com   42s
trust-manager             True    trust-manager-tls         161m

$ kubectl -n venafi get secrets 
NAME                                               TYPE                             DATA   AGE
cert-manager-approver-policy-tls                   Opaque                           3      161m
cert-manager-webhook-ca                            Opaque                           3      162m
sample-cert1.venafi.com                            kubernetes.io/tls                2      45s
sh.helm.release.v1.approver-policy-enterprise.v1   helm.sh/release.v1               1      161m
sh.helm.release.v1.cert-manager.v1                 helm.sh/release.v1               1      162m
sh.helm.release.v1.trust-manager.v1                helm.sh/release.v1               1      161m
sh.helm.release.v1.venafi-connection.v1            helm.sh/release.v1               1      3h
sh.helm.release.v1.venafi-connection.v2            helm.sh/release.v1               1      162m
sh.helm.release.v1.venafi-enhanced-issuer.v1       helm.sh/release.v1               1      161m
trust-manager-tls                                  kubernetes.io/tls                3      161m
venafi-cloud-credentials                           Opaque                           1      46m
venafi-image-pull-secret                           kubernetes.io/dockerconfigjson   1      162m
```


## Ingress

At this step you explore an example of an ingress and how cert manager automate the certificate issuance

Install an ingress controller 

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
```

explore file `venafi-install/helm-podinfo-values.yaml` line 114 to 140, see how an ingress is annotated 

Deploy a test application 

```bash
helm repo add podinfo https://stefanprodan.github.io/podinfo
helm repo update

helm upgrade --install --wait frontend --namespace venafi --values venafi-install/helm-podinfo-values.yaml podinfo/podinfo 
```

Explore the related objects created

```bash
kubectl -n venafi get ingresses
kubectl -n venafi get certificaterequests
kubectl -n venafi get certificates
kubectl -n venafi get secrets
```

If for any reason you would like undeploy the app, the following

```bash
helm -n venafi uninstall frontend
```


[Main Menu](../README.md) | Next [Onboard a Kubernetes Cluster for Discovery](README5.md)
