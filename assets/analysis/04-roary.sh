#!/usr/bin/env bash
#
# 04-roary.sh
#
# Conduct Roary pangenome analysis on the PROKKA annotations for
# Clostridia sequences

# Run roary on species-specific annotations
roary -p 8 -f 2021-08-19_roary/bolteae -r 2021-08-19_split_genomes/bolteae/*.gff
roary -p 8 -f 2021-08-19_roary/clostridioforme -r 2021-08-19_split_genomes/clostridioforme/*.gff
roary -p 8 -f 2021-08-19_roary/symbiosum -r 2021-08-19_split_genomes/symbiosum/*.gff

# Run roary on the combined bolteae and clostridioforme annotations
roary -p 8 -f 2021-08-19_roary/bolteae_clostridioforme -r 2021-08-19_split_genomes/[bc]*/*.gff