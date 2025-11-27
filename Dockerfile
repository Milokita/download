FROM condaforge/miniforge3:latest
RUN apt update && apt upgrade -y 
RUN conda create -n scan2 -c conda-forge -c bioconda -c jluquette -c dranew -c soil scan2
RUN conda install -c conda-forge -c bioconda bioconductor-bsgenome.hsapiens.ucsc.hg38

SHELL ["conda", "run", "-n", "scan2", "/bin/bash", "-c"]
RUN python3 -c "from SigProfilerMatrixGenerator import install as genInstall; genInstall.install('GRCh37', rsync=False, bash=True)"
RUN python3 -c "from SigProfilerMatrixGenerator import install as genInstall; genInstall.install('GRCh38', rsync=False, bash=True)"

# set default shell to bash + conda env
SHELL ["/bin/bash", "-c"]
# Automatically activate the environment when a container starts
ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "scan2"]
