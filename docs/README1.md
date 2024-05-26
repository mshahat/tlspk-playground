TLS Protect for Kubernetes Playground

Review the prerequisites listed in the [Home Page](../README.md)

Step x Prepare a team, an issuing template policy and an application

login to your tenant https://<tenant>.venafi.cloud or https://<tenant>.venafi.eu if you use an EU tenant.
For the rest of this worksho, we will only using venafi.cloud, please remember to use .eu if you are using an EU tenant

<p align="center">
  <img src="../imgs/1.png" width="614" />
</p>

Go to Settings > Teams > New

<p align="center">
  <img src="../imgs/2.png" width="614" />
</p>

Enter the team name e.g. `sys-admin-team`

Choose the owner user for this team. Choose other members if applicable. 

Choose the role e.g. `System Administrator`

<p align="center">
  <img src="../imgs/3.png" width="614" />
</p>

Go to Policies > Issuing Templates > New

<p align="center">
  <img src="../imgs/4.png" width="614" />
</p>

Type the Issuing Template name e.g. `builtin-ca-issuing-template`

Choose the Certificate Authority for this template

For this workshop we will use the Venafi Built in CA that comes ready to use with VaaS

<p align="center">
  <img src="../imgs/5.png" width="614" />
</p>

For Key Generation choose Venafi or user generated

Change the validity for issued certificates. The default is 90 days

<p align="center">
  <img src="../imgs/6.png" width="614" />
</p>

Scroll to the end of the page and choose Allow everyone to consume

<p align="center">
  <img src="../imgs/7.png" width="614" />
</p>

Now the timem comes to create an Application
Go to Applications > New

<p align="center">
  <img src="../imgs/8.png" width="614" />
</p>



<p align="center">
  <img src="../imgs/9.png" width="614" />
</p>

<p align="center">
  <img src="../imgs/10.png" width="614" />
</p>

<p align="center">
  <img src="../imgs/11.png" width="614" />
</p>

<p align="center">
  <img src="../imgs/12.png" width="614" />
</p>

<p align="center">
  <img src="../imgs/13.png" width="614" />
</p>

<p align="center">
  <img src="../imgs/14.png" width="614" />
</p>