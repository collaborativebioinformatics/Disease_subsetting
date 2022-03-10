# Disease_subsetting

![Disease_subsetting_flowchart](https://user-images.githubusercontent.com/82537630/157536530-5d03f842-ca3f-4e15-85df-346d97f5a78d.png)

Pipeline steps:
1. Download CMS SRA data from NCBI using SRA toolkit:

    Run selector for:
    - Colorectal cancer
    - Homo Sapiens
    - RNA
    
    In Selector select:
    - consensus_molecular_subtype
    - cms1, cms2, cms3 and cms4
2. Extract .fastq files from .sra files using fastq-dump:
3. Read mapping using hisat2:
   - hisat2 index for GRCh38 reference genome (NCBI)
   - hisat2 mapper for fastq files
