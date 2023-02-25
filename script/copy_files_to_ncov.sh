#!/usr/bin/env bash

# Run the commands below after creating the nextstrain env with environment.yml file. 
# To do so run mamba create env -f environment.yml 
# This is assuming that you are in the ncov-cames directory

cd ..
git clone https://github.com/nextstrain/ncov.git
cd ncov
cp -r ../ncov-cames/cames_profile .
cp ../ncov-cames/builds_cames.yaml .

# After this, move files downloaded from gisaid.org in your the data directory of ncov local repository directory.
# Then you could run data_formating.sh
