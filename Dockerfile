FROM ghcr.io/milokita/scan2-base:main

SHELL ["bash", "-lc"]

RUN CONDA_AUTO_UPDATE_CONDA=false conda install -c conda-forge -c bioconda bioconductor-bsgenome.hsapiens.ucsc.hg38

SHELL ["conda", "run", "-n", "scan2", "/bin/bash", "-c"]
# RUN python3 -c "from SigProfilerMatrixGenerator import install as genInstall; genInstall.install('GRCh37', rsync=False, bash=True)"
#RUN python3 -c "from SigProfilerMatrixGenerator import install as genInstall; genInstall.install('GRCh38', rsync=False, bash=True)"

# set default shell to bash + conda env
SHELL ["/bin/bash", "-c"]
# Automatically activate the environment when a container starts
ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "scan2"]
