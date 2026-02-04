library(tidyverse)

old <- read.table(
  "data/old/GSE52778_Dex_vs_Untreated_gene_exp.txt.gz",
  header = TRUE,
  sep = "\t",
  stringsAsFactors = FALSE,
  check.names = FALSE
)

old_std <- old %>%
  transmute(
    gene = gene,
    log2FC = `log2(fold_change)`,
    padj = q_value,
    dataset = "OLD_GSE52778"
  ) %>%
  filter(!is.na(padj))

write.table(
  old_std,
  "results/old/old_standardized.tsv",
  sep = "\t",
  quote = FALSE,
  row.names = FALSE
)

new <- read.table(
  "data/new/GSE94335_DE_non_asthma.txt.gz",
  header = TRUE,
  sep = "",
  stringsAsFactors = FALSE,
  check.names = FALSE,
  comment.char = ""
)

print(colnames(new))

new_std <- new %>%
  transmute(
    gene = ext_gene,
    log2FC = b,
    padj = qval,
    dataset = "NEW_GSE94335"
  ) %>%
  filter(!is.na(padj))

dir.create("results", showWarnings = FALSE)
dir.create("results/new", recursive = TRUE, showWarnings = FALSE)

out_new <- normalizePath("results/new/new_standardized.tsv", winslash = "/", mustWork = FALSE)

write.table(
  new_std,
  file = out_new,
  sep = "\t",
  quote = FALSE,
  row.names = FALSE
)

cat("NEW output path:", out_new, "\n")
cat("NEW file exists?", file.exists(out_new), "\n")
stopifnot(file.exists(out_new))


cat("Standardization complete\n")
