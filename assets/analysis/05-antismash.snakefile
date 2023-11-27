GENOMES, = glob_wildcards("2021-07-07_genomes/{genome}.fna")

rule all:
    input:
        expand("2021-08-19_antismash/{genome}/index.html", genome=GENOMES)

rule antismash:
    input:
        "2021-07-07_prokka/{genome}/{genome}.gbk"
    output:
        "2021-08-19_antismash/{genome}/index.html"
    threads: 8
    shell:
        "antismash --output-dir 2021-08-19_antismash/{wildcards.genome} --skip-sanitisation 2021-07-07_prokka/{wildcards.genome}/{wildcards.genome}.gbk"