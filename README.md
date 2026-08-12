# DEPRECATED
The CAVE team has migrated its primary infrastructure as code approach to utilize terraform/terragrunt and helm/helmfile to manage spinning up cloud resources and deploying services to kubernetes. As such, this repo is no longer being actively maintained and we would encourage those looking to deploy CAVE to switch to using the new codebase. 

## [terraform-google-cave](www.github.com/CAVEconnectome/terraform-google-cave)

This is the primary repo to lookat, it includes instructions for getting started and migrating from this infrastructure to the new infrastructure. 

NOTE: at present we have fully migrated our local clusters over to this setup, but have not yet migrated our global server, and so our global server modules and helm charts remain not fully tested at this time and we can't endorse you 

## [cave-helm-charts](www.github.com/CAVEconnectome/cave-helm-charts)

This is the repository that contains our helm charts for deploying services to kubernetes.  This conceptually replaces the templating system and shell scripts that this repository setup.  If you needed to make adjustments to the templates as we had set them up here, you will need to make adjustements to the helm charts here. We would welcome PRs to this repo adding configuration options to the existing charts (with reasonable defaults).  The most important benefit to this helmchart system is that it allows for definitions of options with default, versus options which are required but not specified, so that users don't deploy a service that doesn't have all the configuration it needs.

## [terraform-cave-private](www.github.com/CAVEconnectome/terraform-cave-private)

This repo contains the configuration files for the primary deployments we use for CAVE. One of the other most important advantages to using helm is that it offered us a route to move all sensitive data out of the environment files and into a secure location, then use the helm vals plugin to reference those sensitive values.  As such, we can now make public the configuration files the primary CAVE development team utilizes to deploy infrastructure to 4 different server setups. Others can see precisely how we have set things up and learn from it, rather than having to rely on templates.  

As mentioned above, we have not yet fully tested our global server deployment. 

# CAVEdeployment

This repository contains scripts for deploying all services from CAVE on Google Cloud using kubernetes. The scripts are organized into:
- `infrastructure`: scripts for deployment and creation of service accounts and databases
- `kubetemplates`: templates of the yaml files deployed to kubernetes

Missing from this repository are deployment specific environment files. As these contain not only dfeployment specific but also sensitive information, these are to be kept in private repositories. The location of an environment repository (locally) should be defined in `env_config.sh`. `environment_examples` contains and templated examples for generating initial environment files that can be used as a basis of such a private repository. 

### Two kinds of clusters: global vs local

The CAVE infrastructure consists of `local` and `global` clusters. This distinction is reflected in the subfolder structure in `infrastructure`. Global clusters contain services that are agnostic to specific dataset such as authentication, info, linksharing. Multiple local clusters can be connected to the same global cluster. A local cluster serves dataset / community specific purposes and hosts the pychunkedgraph, annotationengine among other services. A local cluster can support multiple datasets.


### Deployment

Detailed instructions for setup and deployment will be added later. If you are interested in setting up your own CAVE infrastructure please reach out to us and we will share a document outlining the current deployment documentation. 
