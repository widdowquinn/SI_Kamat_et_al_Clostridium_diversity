#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""split_species.py

Ad hoc script to split the Clostridum genomes into folders by
species (as identified) by ANIm.

Input is the tab-delimited file anim_species.txt with the columns:

    label    anim_species

We open 2021-06-19_ANIm/bolteae_clostridioforme_symbiosum_genomes/new_labels.txt
and use this to identify source genome filenames for each isolate.

Using this information, we copy the PROKKA .gff file from the corresponding
directory under 2021-07-07_prokka to a new directory named after anim_species
for that isolate.

These .gff files can then be used for species-specific roary pangenome analysis
"""

import shutil

from pathlib import Path


LABELFILE = Path(
    "2021-06-19_ANIm/bolteae_clostridioforme_symbiosum_genomes/new_labels.txt"
)
OUTDIR = Path("2021-08-19_split_genomes")
PROKKADIR = Path("2021-07-07_prokka")
SPECIESFILE = Path("anim_species.txt")

# Load genome labels with corresponding species
with LABELFILE.open("r") as ifh:
    labels = {
        key: val
        for (hash, key, val) in [
            tuple(_.strip().split("\t")) for _ in ifh.readlines() if _.strip()
        ]
    }
print(f"found {len(labels)} entries in label file")

# Load labels and corresponding species
with SPECIESFILE.open("r") as ifh:
    species = {
        key: val
        for (key, val) in [tuple(_.strip().split("\t")) for _ in ifh.readlines()[1:]]
    }
print(f"found {len(species)} entries in species file")

# Copy prokka output over to new directories
data = [
    (stem, label, species[label])
    for (stem, label) in labels.items()
    if label in species
]
print(f"matched {len(data)} isolates between species and labels")

print("copying prokka data")
prokkadirs = [_.parts[-1] for _ in PROKKADIR.iterdir()]
for stem, label, species in data:
    print(stem)
    if stem in prokkadirs:
        shutil.copyfile(
            PROKKADIR / stem / f"{stem}.gff", OUTDIR / species / f"{stem}.gff"
        )
