from dash_connectivity_viewer import (
    cell_type_connectivity,
    cell_type_table,
    connectivity_table,
)

ct_config = {
    "datastack": "minnie65_phase3_v1",
    "server_address": "https://global.daf-apis.com",
    "image_black": 0.35,
    "image_white": 0.7,
}

conn_config = {
    "cell_type_dropdown_options": [],
    "datastack": "minnie65_phase3_v1",
    "server_address": "https://global.daf-apis.com",
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
    "omit_cell_type_tables": ["nucleus_detection_v0", "nucleus_neuron_svm"],
    "default_cell_type_option": "aibs_soma_nuc_metamodel_preds_v117",
    "image_black": 0.35,
    "image_white": 0.7,
    "height_bounds": [0, 950],
    "layer_bounds": [106, 276, 411, 535, 768],
}

pub_conn_config = conn_config.copy()
pub_conn_config["datastack"] = "minnie65_public"
pub_conn_config["disallow_live_query"] = True

pub343_conn_config = conn_config.copy()
pub343_conn_config["cell_type_dropdown_options"] = [
    {
        "label": "Cell Type Model",
        "value": "aibs_soma_nuc_metamodel_preds_v117",
    },
    {
        "label": "Column Manual Neuron Types",
        "value": "allen_v1_column_types_slanted",
    },
]
pub343_conn_config["datastack"] = "minnie65_public_v343"
pub343_conn_config["disallow_live_query"] = True

pub117_conn_config = conn_config.copy()
pub117_conn_config["cell_type_dropdown_options"] = [
    {
        "label": "EI Model",
        "value": "allen_soma_ei_class_model_v1",
    },
    {
        "label": "Column Manual Neuron Types",
        "value": "allen_visp_column_soma_coarse_types_v1",
    },
]
pub117_conn_config["datastack"] = "minnie65_public_v117"
pub117_conn_config["disallow_live_query"] = True

pinky_conn_config = conn_config.copy()
pinky_conn_config["datastack"] = "pinky_sandbox"
pinky_conn_config["disallow_live_query"] = False
pinky_conn_config["omit_cell_type_tables"] = []
pinky_conn_config.pop("height_bounds")
pinky_conn_config.pop("layer_bounds")
pinky_conn_config.pop("default_cell_type_option")
pinky_conn_config["ct_conn_show_depth_plots"] = False
pinky_conn_config["image_black"] = 0.0
pinky_conn_config["image_white"] = 1.0


SECRET_KEY = "#$%ASDFBASRA2eaasfd"
DASH_DATASTACK_SUPPORT = {
    "pinky_sandbox": {
        "table_viewer": {
            "create_app": cell_type_table.create_app,
            "config": {
                "datastack": "pinky_sandbox",
                "server_address": "https://global.daf-apis.com",
                "image_black": 0.0,
                "image_white": 1.0,
            },
        },
        "connectivity": {
            "create_app": cell_type_connectivity.create_app,
            "config": pinky_conn_config,
        },
    },
    "minnie65_phase3_v1": {
        "table_viewer": {
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
                "datastack": "minnie65_phase3_v1",
                "server_address": "https://global.daf-apis.com",
                "syn_position_column": "ctr_pt",
                "image_black": 0.35,
                "image_white": 0.7,
            },
        },
    },
    "minnie65_public": {
        "table_viewer": {
            "create_app": cell_type_table.create_app,
            "config": {
                "datastack": "minnie65_public",
                "server_address": "https://global.daf-apis.com",
                "image_black": 0.35,
                "image_white": 0.7,
            },
        },
        "connectivity": {
            "create_app": cell_type_connectivity.create_app,
            "config": pub_conn_config,
        },
        "basic_connectivity": {
            "create_app": connectivity_table.create_app,
            "config": {
                "datastack": "minnie65_public",
                "server_address": "https://global.daf-apis.com",
                "syn_position_column": "ctr_pt",
                "image_black": 0.35,
                "image_white": 0.7,
            },
        },
    },
    "minnie65_public_v343": {
        "cell_type": {
            "create_app": cell_type_table.create_app,
            "config": {
                "datastack": "minnie65_public_v343",
                "server_address": "https://global.daf-apis.com",
                "image_black": 0.35,
                "image_white": 0.7,
            },
        },
        "connectivity": {
            "create_app": cell_type_connectivity.create_app,
            "config": pub343_conn_config,
        },
        "basic_connectivity": {
            "create_app": connectivity_table.create_app,
            "config": {
                "datastack": "minnie65_public_v343",
                "server_address": "https://global.daf-apis.com",
                "syn_position_column": "ctr_pt",
                "image_black": 0.35,
                "image_white": 0.7,
            },
        },
    },
    "minnie65_public_v117": {
        "cell_type": {
            "create_app": cell_type_table.create_app,
            "config": {
                "datastack": "minnie65_public_v117",
                "server_address": "https://global.daf-apis.com",
                "image_black": 0.35,
                "image_white": 0.7,
            },
        },
        "connectivity": {
            "create_app": cell_type_connectivity.create_app,
            "config": pub117_conn_config,
        },
        "basic_connectivity": {
            "create_app": connectivity_table.create_app,
            "config": {
                "datastack": "minnie65_public_v117",
                "server_address": "https://global.daf-apis.com",
                "syn_position_column": "ctr_pt",
                "image_black": 0.35,
                "image_white": 0.7,
            },
        },
    },
}
