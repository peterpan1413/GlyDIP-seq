#!/bin/bash

# =============================================================================
# Intersection Analysis between ATAC-seq and GlyDIP-seq promoter peaks
# Also calculates overlap with shuffled (randomized) ATAC peaks as a control
# =============================================================================

# Set genome file for shuffling (ensure it exists)
GENOME_FILE="hg19.genome"

# Target files
ATAC_FILE="ATAC_seq_GMMG2_promoter.bed"
GLY_FILE="GlyDIP_GM_MG1_promoter.bed"

# Step 1: Shuffle ATAC peaks to generate random regions
bedtools shuffle -i "$ATAC_FILE" -g "$GENOME_FILE" > "${ATAC_FILE%.bed}_shuffled.bed"

# Step 2: Calculate overlap count between GlyDIP and shuffled ATAC peaks
overlap_random=$(bedtools intersect -u -a "$GLY_FILE" -b "${ATAC_FILE%.bed}_shuffled.bed" | wc -l)

# Step 3: Count total GlyDIP peaks
total_glydip=$(wc -l < "$GLY_FILE")

# Step 4: Compute percentage overlap
random_percentage=$(echo "scale=2; 100 * $overlap_random / $total_glydip" | bc)

# Output
echo "Overlap with random peaks: $overlap_random / $total_glydip ($random_percentage%)"
