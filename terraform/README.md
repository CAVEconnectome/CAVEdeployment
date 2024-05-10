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


Migration: 

to get existing resources properly mapped into terraform that were created outside of it you need to import them 
from the environment folder.

postgres: 
terraform import module.cave.google_sql_database_instance.postgres SQL_INSTANCE_NAME

i.e.
terraform import module.cave.google_sql_database_instance.postgres svenmd-dynamicannotationframework-ltv


get sql instance names with  ``gcloud sql instances list``

postgres user:
terraform import module.cave.google_sql_user.writer {GOOGLE_PROJECT_ID}/{SQL_INSTANCE_NAME}/{SQL_USER_NAME}
terraform import module.cave.google_sql_user.writer seung-lab/svenmd-dynamicannotationframework-ltv/postgres_write_user

## REDIS
The pychunkedgraph redis instance has cached data about which mesh fragments exist and which don't which helps accelerate the manifest generation for large oct-trees.  It's valuable to hydrate that cache with data from a precious production cache but must be done manually if you are re-running terraform in a new environment.. any data that is lost in the transition will be regenerated the next time it is queries so data integrity is not a huge concern. This information is just a cache

pcg redis:
terraform import module.cave.google_redis_instance.pcg_redis REDIS_INSTANCE_NAME

i.e.
terraform import module.cave.google_redis_instance.pcg_redis ltv-pcg-cache
