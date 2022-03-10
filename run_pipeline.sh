#!bin/bash

#downloading the SRA toolkit
wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.9.1-1/sratoolkit.2.9.1-1-centos_linux64.tar.gz

tar -xzvf sratoolkit.2.9.1-1-centos_linux64.tar.gz

export PATH=$PWD/sratoolkit.2.9.1-1-centos_linux64/bin/:${PATH}

mkdir sraDir

vdb-config -i

#downloading the SRA files
prefetch SRR17233493
prefetch SRR17233501
prefetch SRR17233553
prefetch SRR17233557
prefetch SRR17233561
prefetch SRR17233653
prefetch SRR17233670
prefetch SRR17233675
prefetch SRR17233693
prefetch SRR17233717
prefetch SRR17233746
prefetch SRR17233747
prefetch SRR17233752
prefetch SRR17233760
prefetch SRR17233766
prefetch SRR17233775
prefetch SRR17233787

#extracting fastq files
mkdir fastq

for sraFile in ncbi/public/sra/*.sra; do
 echo "Extracting fastq from "${sraFile}
 fastq-dump \
    --origfmt \
    --gzip \
    --outdir fastq \
    ${sraFile}
done

#downloading the reference genome
wget https://ftp.ncbi.nlm.nih.gov/refseq/H_sapiens/annotation/GRCh38_latest/refseq_identifiers/GRCh38_latest_genomic.fna.gz
