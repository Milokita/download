FROM condaforge/miniforge3:latest
RUN apt update && apt upgrade -y 
RUN conda create -n scan2 -c conda-forge -c bioconda -c jluquette -c dranew -c soil scan2
SHELL ["conda", "run", "-n", "scan2", "/bin/bash", "-c"]
RUN python3 -c "from SigProfilerMatrixGenerator import install as genInstall; genInstall.install('GRCh37', rsync=False, bash=True)"
