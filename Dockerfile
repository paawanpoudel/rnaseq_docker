
FROM rocker/rstudio:3.6.3 
MAINTAINER Pawan Poudel pawan.poudel@astrazeneca.com
LABEL Description="Analysis of gene expression data" Version="1.0"

EXPOSE 8787
# installing additional dependencies
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -yq --no-install-recommends apt-utils git 
RUN apt-get -yq install libgit2-dev
RUN apt-get -yq install libcurl4-gnutls-dev libssl-dev libxml2-dev libgit2-dev zlib1g-dev libpng-dev libcairo2-dev libxt-dev

# installing the required packages
RUN R -e "install.packages('versions', repos = 'https://cran.ma.imperial.ac.uk/', dependencies = TRUE)"
RUN R -e "install.packages('devtools', repos = 'https://cran.ma.imperial.ac.uk/', dependencies = TRUE)"
RUN R -e "install.packages('remotes', repos = 'https://cran.ma.imperial.ac.uk/', dependencies = TRUE)"
RUN R -e "install.packages('BiocManager', repos = 'https://cran.ma.imperial.ac.uk/', dependencies = TRUE)"

RUN R -e "BiocManager::install('SummarizedExperiment')"

# Install MRAN libraries
RUN R -e "versions::install.dates(pkgs = c('rmarkdown','htmltools','NMF','cluster','DESeq2','caret','sva','bookdown','yaml','tidyverse', 'knitr', 'kableExtra', 'pander', 'R.utils', 'argparse', 'magrittr', 'dplyr', 'checkmate','reshape2', 'plyr', 'grid', 'mvtnorm','libcoin', 'multcomp', 'plotmo' ,'plotrix','catools','gplots', 'MASS', 'FactoMineR', 'FARDEEP','Cairo','glue'), dependencies = TRUE, dates = '2020-11-16')"

RUN R -e "versions::install.dates(pkgs = c('RColorBrewer', 'readr', 'stringr', 'ggthemes', 'ggplot2', 'ggpubr','circlize', 'GetoptLong', 'clue', 'GlobalOptions', 'png', 'cowplot'), dependencies = TRUE, dates = '2020-11-16')"

RUN R -e "remotes::install_github('grst/immunedeconv')"
RUN R -e "install.packages('http://download.r-forge.r-project.org/src/contrib/estimate_1.0.13.tar.gz', repos = NULL, type='source')"
RUN R -e "install.packages('https://bioconductor.org/packages/release/bioc/src/contrib/ComplexHeatmap_2.2.0.tar.gz', repos = NULL, type='source')"
RUN R -e "install.packages('https://bioconductor.riken.jp/packages/3.1/data/experiment/src/contrib/ALL_1.10.0.tar.gz', repos = NULL, type='source')"
RUN R -e "install.packages('https://bioconductor.riken.jp/packages/3.1/bioc/src/contrib/ConsensusClusterPlus_1.22.0.tar.gz', repos = NULL, type='source')"


# installing the degnorm R package
RUN R -e "BiocManager::install('DegNorm')"

# Run R when the container launches 
CMD ["R"]

