# This snakemake file is used to generate PROKKA annotation for each of the
# Clostridia genomes

IDS, = glob_wildcards("2021-07-07_genomes/{id}.fna")

rule all:
     input: expand("2021-07-07_prokka/{id}/{id}.gff", id=IDS)

# Run PROKKA on an input genome
rule prokka:
     input: "2021-07-07_genomes/{id}.fna"
     output: outdir=directory("2021-07-07_prokka/{id}"), outgff="2021-07-07_prokka/{id}/{id}.gff",
     shell: "prokka --outdir {output.outdir} --prefix {wildcards.id} --force {input}"