# =============================================================================
# Plot density distribution of ATAC-seq, GlyDIP-seq, and OxiDIP-seq signals
# Description:
#   This script reads promoter pileup signal data for ATAC-seq, GlyDIP-seq,
#   and OxiDIP-seq, and generates a log10-scaled density plot comparing
#   the normalized signal distributions.
# =============================================================================

# Load required library
library(ggplot2)

# -----------------------------
# Load data
# -----------------------------
df <- read.table("D:/ATAC-seq/Figure/ATAC_vs_GlyDIP_promoter.txt",
                 header = FALSE, sep = "\t")

# Extract signal values from specific columns:
# V7 = ATAC-seq, V14 = GlyDIP-seq, V15 = OxiDIP-seq
df$ATAC    <- as.numeric(as.character(df$V7))
df$GlyDIP  <- as.numeric(as.character(df$V14))
df$OxiDIP  <- as.numeric(as.character(df$V15))

# -----------------------------
# Convert to long format
# -----------------------------
df_long <- data.frame(
  Value = c(df$ATAC, df$GlyDIP, df$OxiDIP),
  Type  = factor(
    rep(c("ATAC-seq", "GlyDIP-seq", "OxiDIP-seq"), each = nrow(df)),
    levels = c("GlyDIP-seq", "OxiDIP-seq", "ATAC-seq") # Define legend order
  )
)

# Remove NA and zero or negative values before log transformation
df_long <- df_long[!is.na(df_long$Value) & df_long$Value > 0, ]

# -----------------------------
# Create density plot and export to PDF
# -----------------------------
pdf("D:/ATAC-seq/Figure/ATAC_vs_GlyDIP_OxiDIP_density.pdf", width = 7, height = 5)

ggplot(df_long, aes(x = Value, color = Type)) +
  geom_density(size = 1) +
  scale_x_log10() +
  scale_color_manual(values = c(
    "GlyDIP-seq" = "red",
    "OxiDIP-seq" = "blue",
    "ATAC-seq"   = "green"
  )) +
  labs(
    title = "Signal distribution of ATAC-seq, GlyDIP-seq, and OxiDIP-seq",
    x = "Normalized signal (log10 scale)",
    y = "Density"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    legend.position = c(0.95, 0.95),
    legend.justification = c("right", "top"),
    legend.background = element_rect(fill = "white", color = NA),
    legend.title = element_blank()
  )

dev.off()
