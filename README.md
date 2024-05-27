# Venafi TLS Protect for Kubernetes Playground

## Goals
The repo walks you through some steps to explore the capaiblities of TLS PK 

- Deploy Venafi Enhanced Issuer amongst other components
- Issue certificates using a CA of choice
- Onboard Kubernetes cluster to VaaS for Discovery

## Prerequisites

The following are the prerequistes you need to be able to go through this workshop

- GitHub account
- Access to a VaaS tenant. Kubernetes capabilities need to be enabled
- Chrome Browser recommended. Other Browsers should work

This workshop assumed the use of GitHub codespace. 
This guide is providing good guidance to run the same set up on your own workstation as well, macOS, Linux or Windows


## Steps

- [Configure Venafi Control Plane](docs/README1.md)
- [Deploy Components to a Kubernetes Cluster](docs/README2.md)
- [Create a Cert Manager Issuer](docs/README3.md)
- [Issue Certificates in Kubernetes](docs/README4.md)
- [Onboard a Kubernetes Cluster for Discovery](docs/README5.md)




[Main Menu](README.md) | Next [Configure Venafi Control Plane](docs/README1.md)