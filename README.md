# Disease subsetting and personalized medication recommendation

## What kind of problem are we trying to solve?
The consensus molecular subtypes (CMS) classification classifies colorectal cancer into four molecular subtypes with distinct biological characteristics, which may form the basis for clinical stratification and subtype-based targeted intervention. We aim to develop a tool that would, based on this information, automate drug recommendation for patients with a specific molecular subtype of colorectal cancer.

## What does our tool do?
Our tool performs RNA-seq pathway analysis based on CMS data of the colorectal cancer, in search of differentially (over/under) expressed pathways that are associated with different subtypes of colorectal cancer. The final result of that analysis is visualized in an R Shiny dashboard.

The analysis result is then used to come up with drug recommendations based on enzymes involved in that pathways and finding their inhibitors or activators. Overall, this entire workflow creates a link between a colorectal cancer subtype that a specific patient is suffering from, and a drug that could be used in treatment of the disease. That means that the drug recommendation is personalized.

## Overall pipeline
![Disease_subsetting_flowchart](https://user-images.githubusercontent.com/82537630/157536530-5d03f842-ca3f-4e15-85df-346d97f5a78d.png)

## Pathway analysis
Pipeline steps:
1. Download CMS SRA data from NCBI using SRA toolkit: (https://www.ncbi.nlm.nih.gov/Traces/study/?query_key=3&WebEnv=MCID_622b744a94b9b522d227f612&f=consensus_molecular_subtype_sam_s%3An%3Ac&o=acc_s%3Aa)

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
4. Pathway analysis with pathway_visualisation.R
5. Parsing and radar-plotting of pathway_visualisation.R results (.xml files)

## Visualization
### Output for clinicians and clinical researchers

Things to be included:
* CMS subtype classification
* Tumor site associated with the CMS subtype?
* List of suggested drugs/treatments (potentially ranked)
* Literature sources for those suggested medications/DB links (e.g. KEGG)
* Pathway visualization linked with the drug suggestions

Visualisation of pathway analysis done with demo data:

![target_pathway_figure_example](fig/demo_plot_1.png)

## Treatment recommendations
* The immediate goal right now is to link the pathway analysis output somehow to KEGG pathway or network database. Input could be: pathway/gene, overexpression/underexpression/mutation extent score, as well as a value to represent how focal/common that pathway/gene is to colorectal cancer.
* KEGG API-based applet to fetch all drugs targeting an input gene/pathway has been built.
* We can then build an equation/mini-algorithm to come up with top *n* drugs given the pathway information
* Alternatively, we can solely base it on literature-searched drugs relevant to the specific pathways

## Installation & software requirements

To run the pipeline, Bioconductor needs to be installed:

`BiocManager::install(c("pathview", "gage", "gageData", "GenomicAlignments","TxDb.Hsapiens.UCSC.hg19.knownGene"))`


