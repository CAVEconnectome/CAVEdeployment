# CAVEdeployment

This repository contains scripts for deploying all services from CAVE on Google Cloud using kubernetes. The scripts are organized into:
- `infrastructure`: scripts for deployment and creation of service accounts and databases
- `kubetemplates`: templates of the yaml files deployed to kubernetes

Missing from this repository are deployment specific environment files. As these contain not only dfeployment specific but also sensitive information, these are to be kept in private repositories. The location of an environment repository (locally) should be defined in `env_config.sh`. `environment_examples` contains and templated examples for generating initial environment files that can be used as a basis of such a private repository. 

### Two kinds of clusters: global vs local

The CAVE infrastructure consists of `local` and `global` clusters. This distinction is reflected in the subfolder structure in `infrastructure`. Global clusters contain services that are agnostic to specific dataset such as authentication, info, linksharing. Multiple local clusters can be connected to the same global cluster. A local cluster serves dataset / community specific purposes and hosts the pychunkedgraph, annotationengine among other services. A local cluster can support multiple datasets.


### Deployment

Detailed instructions for setup and deployment will be added later. If you are interested in setting up your own CAVE infrastructure please reach out to us and we will share a document outlining the current deployment documentation. 
