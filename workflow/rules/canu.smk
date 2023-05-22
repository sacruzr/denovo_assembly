import os, sys

rule canu_denovo_assembly:
    input:
        corrected_reads = get_corrected_reads
    
    output:
        directory('results/{sample}/assembly/canu')
    
    threads: 
        resources['CANU']['threads']

    params:
        genome_size = config['organism']['genome_size_mb']

    log:
        "results/{sample}/assembly/canu.log"

    conda:
        "denovo_assembly_pipeline"
    shell: 
        """
        canu -trim-assemble \
        -p {wildcards.sample} \
        -d {output} \
        genomeSize={params.genome_size}m \
        useGrid=false \
        maxThreads={threads} \
        -corrected -nanopore {input} 1> {log}
        """

