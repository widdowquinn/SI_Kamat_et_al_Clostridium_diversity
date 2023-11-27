#!/usr/bin/env bash
#
# call_cds.sh
#
# Call CDS in Clostridia genomes using prodigal.
# We use this approach to ensure consistency in downstream
# analyses; results will not be conditioned on choice of CDS/
# gene caller.

# Create output directories
OUTPUT_DIR=2021-06-22_CDS
mkdir -p ${OUTPUT_DIR}/proteins
mkdir -p ${OUTPUT_DIR}/cds
mkdir -p ${OUTPUT_DIR}/gbk

# Define input directory
GENOME_DIR=2021-06-19_ANIm/bolteae_clostridioforme_symbiosum_genomes

# Annotate .fasta files
for fname in ${GENOME_DIR}/*.fasta
do
  prodigal \
      -a ${OUTPUT_DIR}/proteins/`basename ${fname%%fasta}`faa \
      -d ${OUTPUT_DIR}/cds/`basename ${fname%%fasta}`fasta \
      -i ${fname} \
      -o ${OUTPUT_DIR}/gbk/`basename ${fname%%fasta}`gbk
done

# Annotate .fna files
for fname in ${GENOME_DIR}/*.fna
do
  prodigal \
      -a ${OUTPUT_DIR}/proteins/`basename ${fname%%fna}`faa \
      -d ${OUTPUT_DIR}/cds/`basename ${fname%%fna}`fasta \
      -i ${fname} \
      -o ${OUTPUT_DIR}/gbk/`basename ${fname%%fna}`gbk
done