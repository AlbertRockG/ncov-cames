FROM snakemake/snakemake:stable
RUN exit
RUN conda init --all && \
    conda activate && \
    source /root/.bashrc;
RUN mamba create -n nextstrain --clone snakemake; \
    mamba env update -n nextstrain -f environment.yml;
RUN mkdir -p /tmp/conda
ENV CONDA_PKGS_DIRS /tmp/conda
