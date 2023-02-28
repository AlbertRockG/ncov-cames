FROM mambaorg/micromamba:0.25.1

LABEL image.author.name "AlbertRockG"
LABEL image.author.email "rafgangbadja@gmail.com"


RUN micromamba create -n nextstrain

RUN micromamba install nextstrain-cli \
               -c conda-forge \
               -c bioconda \
               --strict-channel-priority \
               --override-channels

RUN nextstrain setup conda

RUN nextstrain setup --set-default conda

ENV PATH /opt/conda/envs/nextstrain/bin:$PATH
