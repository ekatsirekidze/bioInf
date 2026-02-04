library(tidyverse)

old <- read_tsv("results/old/old_standardized.tsv", show_col_types = FALSE)
new <- read_tsv("results/new/new_standardized.tsv", show_col_types = FALSE)

sig_old <- old %>% filter(padj < 0.05, !is.na(gene), gene != "", gene != "NA")
sig_new <- new %>% filter(padj < 0.05, !is.na(gene), gene != "", gene != "NA")

old_genes <- sort(unique(sig_old$gene))
new_genes <- sort(unique(sig_new$gene))
overlap_genes <- intersect(old_genes, new_genes)

dir.create("results/comparison", recursive = TRUE, showWarnings = FALSE)
write_tsv(tibble(gene = overlap_genes), "results/comparison/significant_overlap.tsv")

summary_tbl <- tibble(
  old_sig = length(old_genes),
  new_sig = length(new_genes),
  overlap_sig = length(overlap_genes),
  jaccard = length(overlap_genes) / (length(old_genes) + length(new_genes) - length(overlap_genes))
)

write_tsv(summary_tbl, "results/comparison/summary.tsv")
print(summary_tbl)


old_genelevel <- sig_old %>%
  group_by(gene) %>%
  slice_min(order_by = padj, n = 1, with_ties = FALSE) %>%
  ungroup() %>%
  select(gene, log2FC)

new_genelevel <- sig_new %>%
  group_by(gene) %>%
  slice_min(order_by = padj, n = 1, with_ties = FALSE) %>%
  ungroup() %>%
  select(gene, log2FC)

overlap_df <- inner_join(old_genelevel, new_genelevel, by = "gene",
                         suffix = c(".old", ".new"))

write_tsv(overlap_df, "results/comparison/overlap_gene_log2fc.tsv")

if (nrow(overlap_df) >= 3) {
  rho <- cor(overlap_df$log2FC.old, overlap_df$log2FC.new, method = "spearman")
  cat("Spearman rho (log2FC) on overlapped significant genes:", rho, "\n")

  png("results/comparison/log2FC_correlation.png", width = 900, height = 900)
  plot(
    overlap_df$log2FC.old, overlap_df$log2FC.new,
    xlab = "OLD log2FC (Dex vs Untreated)",
    ylab = "NEW log2FC (BUD vs Vehicle)",
    main = paste0("log2FC agreement (Spearman rho = ", round(rho, 2), ")")
  )
  abline(h = 0, v = 0, col = "gray")
  dev.off()
} else {
  cat("Not enough overlapped genes to compute correlation.\n")
}
