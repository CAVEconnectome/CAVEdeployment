1. Install terraform
2. Install helm
3. make sure you can login to your google account, and you have a google project setup with the follwoing permissions on your account. 

service account user
kubernetes adminsitrator

4. This assumes you have setup bigtable and ingested some data into a table seperately.  This is currently managed by a seperate process documented and outlined in seung-lab/CAVEpipelines.  If you need to read more about how to format your segmentation result to be ingested look at thie markdown file [TODO: ADD LINK]

5. create a new environment in environments folder. Follow pattern found in example_environment.  Fill in values in the terraform.tfvars folder. 

Navigate to your environment folder.

::
   terraform init

if this is a production environemnt, we reccomend setting up blue/green workspaces, so you can spin up a new workspace with no downtime when there are significant changes to the infrastructure beyond upgrading microservice versions. 

