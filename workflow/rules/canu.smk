import os, sys

def get_samples_to_process():
    sequence_files = os.listdir('resources/sequences/')
    samples_process = [sample.split('.')[0] for sample in sequence_files]
    return samples_process

samples_to_process = get_samples_to_process()

rule all:
    input: expand('results/assembly/canu/{sample}', sample=samples_to_process)

rule canu_denovo_assembly:
    output:'results/assembly/canu/{sample}'
    input:'resources/sequences/{sample}.fastq.gz'
    log:'results/assembly/canu/{sample}/canu_assembly.log'
    threads: config['canu_threads']
    shell: 
        """
        canu -p {wildcards.sample} \
        -d {output} \
        genomeSize={config[genome_size]}m \
        useGrid=false \
        maxThreads={threads} \
        -nanopore {input} 1> {log}
        """

