environment                = "ltv7"
owner                      = "cave"
project_id                 = "seung-lab"
region                     = "us-east1"
zone                       = "us-east1-b"
gcp_user_account           = "forrest.collman@gmail.com"

# dns variables
dns_zone                   = "microns-daf-zone"
domain_name                = "microns-daf.com"
dns_entries                = {
                            "ltv7" = {
                                zone        = "microns-daf-zone"
                                domain_name = "ltv7"
                            }
                            }
letsencrypt_email          = "forrestc@alleninstitute.org"

# postgres setup
sql_instance_name          = "svenmd-dynamicannotationframework-ltv"
postgres_user_password     = "welcometothematrix"
sql_instance_memory_gb     = 10
sql_instance_cpu           = 2


# pcg/l2cache setup variables
bigtable_instance_name     = "pychunkedgraph"
pcg_bucket_name            = "seunglab2"
bigtable_google_project    = "neuromancer-seunglab-import"
pcg_redis_name             = "ltv-pcg-cache"