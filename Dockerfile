FROM ghcr.io/milokita/scan2-base:main

# Use bash so we can `source` conda.sh and `conda activate`
SHELL ["bash", "-lc"]

# 1) Update conda in the *base* env
RUN conda update -n base -c conda-forge -y conda

# 2) Activate env "scan2" and install the Bioconductor package there
RUN source /opt/conda/etc/profile.d/conda.sh && \
    conda activate scan2 && \
    CONDA_AUTO_UPDATE_CONDA=false conda install -y \
      -c conda-forge -c bioconda \
      bioconductor-bsgenome.hsapiens.ucsc.hg38

# 3) For the rest of the image, always run inside "scan2"
SHELL ["conda", "run", "-n", "scan2", "/bin/bash", "-c"]

RUN python3 -c "from SigProfilerMatrixGenerator import install as genInstall; genInstall.install('GRCh38', rsync=False, bash=True)"
