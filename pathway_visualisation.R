

# Step 1: Count the reads mapped to each gene
if (!requireNamespace("BiocManager", quietly=TRUE))
  install.packages("BiocManager")
BiocManager::install(c("pathview", "gage", "gageData", "GenomicAlignments","TxDb.Hsapiens.UCSC.hg19.knownGene"))
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
exByGn <- exonsBy(TxDb.Hsapiens.UCSC.hg19.knownGene, "gene")
library(GenomicAlignments)
fls <- list.files("tophat_all/", pattern="bam$", full.names =T)
bamfls <- BamFileList(fls)
flag <- scanBamFlag(isSecondaryAlignment=FALSE, isProperPair=TRUE)
param <- ScanBamParam(flag=flag)

#to run multiple core option: library(parallel); options("mc.cores"=4)
gnCnt <- summarizeOverlaps(exByGn, bamfls, mode="Union",ignore.strand=TRUE, singleEnd=FALSE, param=param)
hnrnp.cnts=assay(gnCnt)


#Step 2: Normalize and process read counts
require(gageData) #demo only
data(hnrnp.cnts) #demo only
cnts=hnrnp.cnts
sel.rn=rowSums(cnts) != 0
cnts=cnts[sel.rn,]
##joint workflow with DEseq/edgeR/limma/Cufflinks forks here
libsizes=colSums(cnts)
size.factor=libsizes/exp(mean(log(libsizes)))
cnts.norm=t(t(cnts)/size.factor)
cnts.norm=log2(cnts.norm+8)

##step 3: gage
##joint workflow with DEseq/edgeR/limma/Cufflinks merges around here
library(gage)
ref.idx=5:8
samp.idx=1:4
data(kegg.gs)

cnts.kegg.p <- gage(cnts.norm, gsets = kegg.gs, ref = ref.idx,samp = samp.idx, compare ="unpaired")
##step 4: pathview
cnts.d= cnts.norm[, samp.idx]-rowMeans(cnts.norm[, ref.idx])
sel <- cnts.kegg.p$greater[, "q.val"] < 0.1 & !is.na(cnts.kegg.p$greater[,"q.val"])
path.ids <- rownames(cnts.kegg.p$greater)[sel]
sel.l <- cnts.kegg.p$less[, "q.val"] < 0.1 & !is.na(cnts.kegg.p$less[,"q.val"])
path.ids.l <- rownames(cnts.kegg.p$less)[sel.l]
path.ids2 <- substr(c(path.ids, path.ids.l), 1, 8)
library(pathview)
pv.out.list <- pathview(gene.data = cnts.d, pathway.id = path.ids2, species = "hsa")