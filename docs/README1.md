# Configure Venafi Control Plane

In this stage of the setup, you work on configuring the Venafi Control Plane with required objects to facilitite the certificate issuance later

- Create a team
- Create an issuing template
- Create an application
- Create a service account as a pull secret for the venafi private registry


## Create a team

Review the prerequisites listed in the [Home Page](../README.md)

Step x Prepare a team, an issuing template policy and an application

login to your tenant https://<tenant>.venafi.cloud or https://<tenant>.venafi.eu if you use an EU tenant.
For the rest of this worksho, we will only using venafi.cloud, please remember to use .eu if you are using an EU tenant

<p align="center">
  <img src="../imgs/1.png" width="800" />
</p>

Go to Settings > Teams > New

<p align="center">
  <img src="../imgs/2.png" width="800" />
</p>

Type in the team name e.g. `sys-admin-team`

Choose the owner user for this team. Choose other members if applicable. 

Choose the role e.g. `System Administrator`

<p align="center">
  <img src="../imgs/3.png" width="800" />
</p>

## Create an issuing template

Go to Policies > Issuing Templates > New

<p align="center">
  <img src="../imgs/4.png" width="800" />
</p>

Type in the Issuing Template name e.g. `builtin-ca-issuing-template`

Choose the Certificate Authority for this template

For this workshop we will use the Venafi Built in CA that comes ready to use with VaaS

<p align="center">
  <img src="../imgs/5.png" width="800" />
</p>

For Key Generation choose Venafi or user generated

Change the validity for issued certificates. The default is 90 days

<p align="center">
  <img src="../imgs/6.png" width="800" />
</p>

Scroll to the end of the page and choose Allow everyone to consume

<p align="center">
  <img src="../imgs/7.png" width="800" />
</p>

## Create an application

Now the time comes to create an Application
Go to Applications > New

<p align="center">
  <img src="../imgs/8.png" width="800" />
</p>

Type in the application name e.g. `app-a-builtin`

Choose the owner team or user

Choose the Issuing Template e.g. `builtin-ca-issuing-template` that we have configured earlier

Now you are ready to issue certificates

<p align="center">
  <img src="../imgs/9.png" width="800" />
</p>

## Create a service account as a pull secret


The Next step is to prepare for the deployment of the Cert Manager and other components to a kubernetes cluster.

The venafi images and helm charts are hosted on a trusted Venafi private registry `private-registy.venafi.cloud`

To pull or deploy images and charts You need a pull secret that is used to authenticate with the Venafi private registry 

Go to Settings > Service Accounts > New

<p align="center">
  <img src="../imgs/10.png" width="800" />
</p>

Add a New Service Account. Choose Use case *Venafi Registry* and click Continue

<p align="center">
  <img src="../imgs/11.png" width="800" />
</p>

Type in the service account name e.g. `techtraining-pullsecret-052024`

Choose the Owning Team e.g. `sys-admin-team`

Choose the scope of the Service account, in this case choose all the possible scope values

Then click Create

<p align="center">
  <img src="../imgs/12.png" width="800" />
</p>

<p align="center">
  <img src="../imgs/13.png" width="800" />
</p>

Copy the values to a text file and keep them as we will need them at a later stage

Choose Installation Options as Kubernetes

<p align="center">
  <img src="../imgs/14.png" width="800" />
</p>


[Main Menu](../README.md) | Next [Deploy Components to a Kubernetes Cluster](README2.md)