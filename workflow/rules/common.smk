import pandas as pd
from yaml import safe_load


# Snakemake configuration
configfile: "config/config.yaml"

with open(config["resources_config"], "r") as f:
    resources = safe_load(f)

config['organism']['genome_size_mb'] = int(config['organism']['genome_size']/1e6)


sample_units = pd.read_table(config["sample_units"], sep='\t')
sample_units.set_index('sample_name', drop=False, inplace=True)


def get_read_list_per_sample(wildcards):
	read_file = sample_units.loc[wildcards.sample, 'read_file_path']
	return [read_file]