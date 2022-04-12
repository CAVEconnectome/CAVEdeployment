from dash_connectivity_viewer import (
    cell_type_connectivity,
    cell_type_table,
    connectivity_table,
)

ct_config = {
    "datastack": "a_datastack_name",
    "server_address": "https://global.mydns-name.com",
    "ct_cell_type_schema": {
        "cell_type_local": None,
    },
    "image_black": 0.35,
    "image_white": 0.7,
    "cell_type_dropdown_options": [
        {
            "label": "My special cell type description",
            "value": "my_cell_type_table_v1",
        }
    ],
    "omit_cell_type_tables": ["too_big_cell_type_table"]
}

conn_config = {
    "cell_type_dropdown_options": [
        {
            "label": "My special cell type description",
            "value": "my_cell_type_table_v1",
        }
    ],,
    "datastack": "a_datastack_name",
    "server_address": "https://global.mydns-name.com",
    "syn_position_column": "ctr_pt",
    "synapse_aggregation_rules": {
        "mean_size": {
            "column": "size",
            "agg": "mean",
        },
        "net_size": {
            "column": "size",
            "agg": "sum",
        },
    },
    "ct_conn_cell_type_schema": {
        "cell_type_local": None,
    },
    "omit_cell_type_tables": ["too_big_cell_type_table"],
    "valence_map": {
        "my_cell_type_table_v1": {
            "column": "classification_system",
            "e": "my_excitatory_label",
            "i": "my_inhibitory_label",
        }
    },
    "default_cell_type_option": "my_cell_type_table_v1",
    "image_black": 0.35,
    "image_white": 0.7,
}


SECRET_KEY = "a_super_secret_key_for_csrf"
DASH_DATASTACK_SUPPORT = {
    "a_datastack_name": {
        "cell_type": {
            "create_app": cell_type_table.create_app,
            "config": ct_config,
        },
        "connectivity": {
            "create_app": cell_type_connectivity.create_app,
            "config": conn_config,
        },
        "basic_connectivity": {
            "create_app": connectivity_table.create_app,
            "config": {
                "datastack": "a_datastack_name",
                "server_address": "https://global.daf-apis.com",
                "syn_position_column": "ctr_pt",
                "image_black": 0.35,
                "image_white": 0.7,
            },
        },
    }
}