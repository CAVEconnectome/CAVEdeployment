from jinja2 import Environment, FileSystemLoader


def create_spaced_list_of_strings(l):
    return " ".join(
        [
            f'"{s}"' if s.startswith("$") and not s.startswith("${") else f"{s}"
            for s in l
        ]
    )


var_dict = {
    "environment_name": "global_depl",
    "project_name": "my_project",
    "depl_region": "sweet-sweet-kingdom",
    "depl_zone": "sweet-sweet-kingdom-a",
    "dns_zone": "kingdom",
    "domain_name": "domain",
    "letsencrypt_email": "my_email",
    "docker_repository": "docker.io/caveconnectome",
    "add_dns_hostnames": ["add_hostname1", "add_hostname2"],
    "add_dns_zones": ["$DNS_ZONE", "add_zone"],
    "postgres_password": "my_sweet_secret",
    "sql_instance_name": "daf-global-depl",
    "add_storage_secrets": ["my-secret-secret.json", "my-secret-secret2.json"],
    "global_server": "global.my-dns.com",
    "infoservice_csrf_key": "random_key",
    "infoservice_secret_key": "random_key",
    "authservice_secret_key": "random_key",
    "ngl_link_db_table_name": "ngl_link_db",
}

# Additional modifications to parameters and checks
var_dict["dns_hostnames"] = create_spaced_list_of_strings(
    ["$DNS_HOSTNAME"] + var_dict["add_dns_hostnames"]
)
var_dict["dns_zones"] = create_spaced_list_of_strings(
    ["$DNS_ZONE"] + var_dict["add_dns_hostnames"]
)

# Load and render template
env = Environment(loader=FileSystemLoader("."))
template = env.get_template("global_env_template.sh")
rendered_template = template.render(var_dict)

# Write rendered tempalte
with open(f"{var_dict['environment_name']}.sh", "w") as f:
    f.write(rendered_template)
