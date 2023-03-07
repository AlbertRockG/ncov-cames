#!/usr/bin/env bash

# To run either from ncov/ or ncov-cames/ directory

# Get metadata for Africa directly from tarball.
tar xOf data/metadata_tsv.tar.xz metadata.tsv \
  | tsv-filter -H --str-in-fld Location:Africa \
  | xz -c -2 > data/metadata_africa.tsv.xz

# Get strain names for genomes.
# GISAID uses virus name, collection date, and submission date.
# delimited by a pipe character.

xz -c -d data/metadata_africa.tsv.xz \
  | tsv-select -H -f 'Virus\ name','Collection\ date','Submission\ date' \
  | sed 1d \
  | awk -F "\t" '{ print $1"|"$2"|"$3 }' > data/strains_africa.txt

# Get genomes for strain names from tarball.
tar xOf data/sequences_fasta.tar.xz sequences.fasta \
  | seqkit grep -n -f data/strains_africa.txt | xz -c -2 > data/sequences_africa.fasta.xz
