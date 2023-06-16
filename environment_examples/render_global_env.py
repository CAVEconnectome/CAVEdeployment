from jinja2 import Environment, FileSystemLoader
import shlex


def create_spaced_list_of_strings(l):
    return " ".join(
        [
            f'"{s}"' if s.startswith("$") and not s.startswith("${") else f"{s}"
            for s in l
        ]
    )


var_dict = {
    "environment_name": "global",
    "project_name": "mygoogleproject",
    "depl_region": "us-east1",
    "depl_zone": "us-east1-b",
    "dns_zone": "myclouddnszone",
    "domain_name": "mydns.com",
    "letsencrypt_email": "myemail@email.com",
    "docker_repository": "docker.io/caveconnectome",
    "add_dns_hostnames": [
        "${ENVIRONMENT}.myextradns.com",
    ],
    "add_dns_zones": [
        "myextraclouddns-zone",
    ],
    "postgres_password": "mysecretpassword",
    "sql_instance_name": "cave-global",
    "add_storage_secrets": ["optionalpathtosecret.json"],
    "global_server": "global.mydns.com",
    "infoservice_csrf_key": "kibhfugtyknjbjkop",
    "infoservice_secret_key": "lnjk;buigjkloihjhj",
    "authservice_secret_key": "ohijlkhogiulkjnjop",
    "ngl_link_db_table_name": "neuroglancerjsondb",
    "default_admins": [
        ["admin1@email.com", "Admin1First Admin1Last", "Admin1PI"],
        ["admin2@email.com", "Admin2First Admin2Last", "Admin2PI"],
    ],
}

# Additional modifications to parameters and checks
var_dict["dns_hostnames"] = create_spaced_list_of_strings(
    ["$DNS_HOSTNAME"] + var_dict["add_dns_hostnames"]
)
var_dict["dns_zones"] = create_spaced_list_of_strings(
    ["$DNS_ZONE"] + var_dict["add_dns_zones"]
)
var_dict["postgres_password"] = shlex.quote(var_dict["postgres_password"])

# Load and render template
env = Environment(loader=FileSystemLoader("."))
template = env.get_template("global_env_template.sh")
rendered_template = template.render(var_dict)

# Write rendered tempalte
with open(f"{var_dict['environment_name']}.sh", "w") as f:
    f.write(rendered_template)
