FROM condaforge/miniforge3:latest
RUN apt update && apt upgrade -y 
RUN conda create -n scan2 -c conda-forge -c bioconda -c jluquette -c dranew -c soil scan2
RUN conda activate scan2
RUN python3 -c "from SigProfilerMatrixGenerator import install as genInstall; genInstall.install('GRCh37', rsync=False, bash=True)"
