# GlyDIP-seq

![image](https://github.com/user-attachments/assets/2e5edaa6-57e3-4e3f-bcbf-1e908d40cf1b)

## my_script.sh
This script does the following:
- Step 1 remove PCR duplication, mitochondria DNA, ENCODE blacklist
- Step 2 Normalized by GC content
- Step 3 peak call by MACS3
- Step 4 annotate by chipseaker
- Step 5 differential analysis by edgeR
- Step 6 correlation plot with different cell lines
- Step 7 signal intensity aound transcription start sites
- Step 8 GC content
- Step 9 coverage downsampling
- Step 10 relationship between GlyDIP/OxiDIP-seq and SFARI score
- Step 11 correlation plot from GlyDIP/OxiDIP-seq with RNA-seq
- Step 12 

### Usage
```bash
./my_script.sh [arguments]
