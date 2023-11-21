[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/AlbertRockG/ncov-cames)
# SARS-CoV-2 build definitions for African and Malagasy Council of Higher Education (CAMES)

Build configuration for CAMES SARS-CoV-2 hosted at https://nextstrain.org/community/AlbertRockG/ncov-cames.

## Instructions for running CAMES builds with GISAID data

### Setup environment

It's up to you to choose your environment. Whichever you choose, feel free to check the [documentation](https://docs.nextstrain.org/projects/cli/en/stable/) of nextstrain to install the required packages.

### Setup repositories

```
git clone https://github.com/AlbertRockG/ncov-cames.git
git clone https://github.com/nextstrain/ncov.git
cd ncov
cp -r ../ncov-cames/cames_profile .
cp ../ncov-cames/builds_cames.yaml .
```
[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/AlbertRockG/ncov-cames)

# SARS-CoV-2 Build Definitions for African and Malagasy Council of Higher Education (CAMES)

Welcome to the repository for the SARS-CoV-2 genomics epidemiology analysis conducted for the [Also-Covid-19 Project](https://www.lecames.org/prix-macky-sall-pour-la-recherche-du-cames-60-millions-de-francs-pour-une-equipe-pluridisciplinaire-travaillant-sur-les-differents-aspects-de-la-covid-19/) in collaboration with the African and Malagasy Council of Higher Education (CAMES).

## Introduction

This project aims to provide comprehensive build configurations for CAMES SARS-CoV-2, hosted at [Nextstrain Community Builds](https://nextstrain.org/community/AlbertRockG/ncov-cames). The analysis focuses on understanding the genomic epidemiology of SARS-CoV-2 in African and Malagasy regions.

## Getting Started

### Setup Environment

Choose your preferred environment for running the analysis. Refer to the [Nextstrain documentation](https://docs.nextstrain.org/projects/cli/en/stable/) for installing the necessary packages.

### Setup Repositories

```bash
git clone https://github.com/AlbertRockG/ncov-cames.git
git clone https://github.com/nextstrain/ncov.git
cd ncov
cp -r ../ncov-cames/cames_profile .
cp ../ncov-cames/builds_cames.yaml .

```

### Download data

Login to [GISAID (gisaid.com)](https://www.gisaid.org/) and select the "EpiCoV" link from the navigation.

Select the `Downloads` link from the EpiCoV navigation bar. Scroll to the `Genomic epidemiologiy` section and select the `nextregions` button. Select the `Africa` button. Save the file as `hcov_africa.tar.gz` in the `ncov/data/` workflow directory.

Click `Back` to return to the main `Download` dialog, find the `Download packages` section, and select the `FASTA` button. Save the full GISAID sequence as `data/sequences_fasta.tar.xz`.

Select the `metadata` button from that same `Download packages` section and download the corresponding file as `data/metadata_tsv.tar.xz`.

## Filter data

From an existing `nextstrain` conda environment, install extra tools to extract data from GISAID files.

```
# Install tsvutils and UCSC command to extract sequences.
# You only need to do this once.
conda activate nextstrain
conda install -c conda-forge -c bioconda tsv-utils ucsc-fasomerecords
```

Extract African metadata and sequences from full GISAID downloads.

```
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
  | seqkit grep -n -f data/strains_africa.txt /dev/stdout \
  | xz -c -2 > data/sequences_africa.fasta.xz
```

### Run builds locally

Navigate to the ncov workflow directory; these instructions assume this is a sibling directory to this repository. By defaul, the following command will run builds for all CAMES' countries, CAMES, and African's regions.

```
nextstrain build \
    --cpus 4 \
    --memory 8Gib \
    . \
    --configfile builds_cames.yaml \
    --config active_builds=CAMES
```
### Visualize your builds

To visualize your builds, follow the tutorial under [this link](https://docs.nextstrain.org/projects/auspice/en/stable/introduction/install.html) to install Auspice web App. Then run from `ncov` directory:

```
nextstrain view auspice
```
## Acknowledgments

A heartfelt thank you to the [PTR-SANTE CAMES](https://www.linkedin.com/in/ptr-sante-cames-25b140203/?originalSubdomain=bj) Board and [Dr Luc Salako Djogbenou](https://www.linkedin.com/in/luc-djogb%C3%A9nou-088999124/) for their unwavering support and valuable contributions to this initiative.
