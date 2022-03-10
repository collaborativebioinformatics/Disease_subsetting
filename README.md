# Disease_subsetting

## Overall pipeline
![Disease_subsetting_flowchart](fig/Untitled Diagram.drawio)

## Pathway analysis
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

## Treatment suggestion
* The immediate goal right now is to link the pathway analysis output somehow to KEGG pathway or network database. Input could be: pathway/gene, overexpression/underexpression/mutation extent score, as well as a value to represent how focal/common that pathway/gene is to colorectal cancer.
* KEGG API-based applet to fetch all drugs targeting an input gene/pathway has been built.
* We can then build an equation/mini-algorithm to come up with top *n* drugs given the pathway information
* Alternatively, we can solely base it on literature-searched drugs relevant to the specific pathways

## Visualization
This is the output that gets shown to the doctors.

Things to be included:
* CMS subtype classification
* Tumor site associated with the CMS subtype?
* List of suggested drugs/treatments (potentially ranked)
* Literature sources for those suggested medications/DB links (e.g. KEGG)
* Pathway visualization linked with the drug suggestions

e.g. target pathway:

![target_pathway_figure_example](fig/target_pathway_figure_example.png)
