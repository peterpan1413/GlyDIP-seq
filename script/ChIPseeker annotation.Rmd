---
title: "R Notebook"
output: html_notebook
---

This is an [R Markdown](http://rmarkdown.rstudio.com) Notebook. When you execute code within the notebook, the results appear beneath the code.  

Try executing this chunk by clicking the *Run* button within the chunk or by placing your cursor inside it and pressing *Ctrl+Shift+Enter*.

---

## **Analysis Workflow**
1. **Install and Load Required Packages**
2. **Peak Annotation using ChIPseeker**

---

## **Step 1: Install and Load Required Packages**
```{r}
# Install required packages
install.packages("ChIPseeker")
install.packages("TxDb.Hsapiens.UCSC.hg19.knownGene")
install.packages("org.Hs.eg.db")
install.packages("GenomicRanges")

# Load required libraries
library(ChIPseeker)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(org.Hs.eg.db)
library(GenomicRanges)
```



## **Step 2: Peak Annotation using ChIPseeker**
```{r}
# Specify TxDb database
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

# Read BED file as a GRanges object
Peakx100 <- readPeakFile("D:/GlyDIP_x100/MACS3_output/AG_MG2_summits.bed")

# Perform annotation
peakAnnox100 <- annotatePeak(
  Peakx100,
  tssRegion = c(-1000, 1000),  # Define TSS region range
  TxDb = txdb,
  annoDb = "org.Hs.eg.db"
)

# Display annotation results
print(peakAnnox100)

# Save annotation results as a pie chart in a PDF file
pdf("AG_MG2_glydip_annotation.pdf")  # Start creating PDF file
plotAnnoPie(peakAnnox100)             # Generate plot
dev.off()                              # Close PDF file

# Convert annotation results to a data frame
peakAnno_dfx100 <- as.data.frame(peakAnnox100)

# Save results as a CSV file
write.csv(peakAnno_dfx100, file = "AG_MG2_glydip_annotation.csv", row.names = FALSE)
