FROM condaforge/mambaforge:latest

LABEL image.author.name "AlbertRockG"
LABEL image.author.email "rafgangbadja@gmail.com"

RUN apt-get -y update && apt-get -y install git

RUN mamba create -n nextstrain nextstrain-cli \
-c conda-forge \
-c bioconda \
--strict-channel-priority \
--override-channels

ENV PATH /opt/conda/envs/nextstrain/bin:$PATH

RUN nextstrain setup conda && nextstrain setup \
--set-default conda
