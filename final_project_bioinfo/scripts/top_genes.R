library(tidyverse)

old <- read_tsv("results/old/old_standardized.tsv", show_col_types = FALSE)
new <- read_tsv("results/new/new_standardized.tsv", show_col_types = FALSE)

dir.create("results/comparison", recursive = TRUE, showWarnings = FALSE)

top_old_up <- old %>% filter(padj < 0.05) %>% arrange(desc(log2FC)) %>% slice(1:25)
top_old_dn <- old %>% filter(padj < 0.05) %>% arrange(log2FC) %>% slice(1:25)

top_new_up <- new %>% filter(padj < 0.05) %>% arrange(desc(log2FC)) %>% slice(1:25)
top_new_dn <- new %>% filter(padj < 0.05) %>% arrange(log2FC) %>% slice(1:25)

write_tsv(top_old_up, "results/comparison/top25_old_up.tsv")
write_tsv(top_old_dn, "results/comparison/top25_old_down.tsv")
write_tsv(top_new_up, "results/comparison/top25_new_up.tsv")
write_tsv(top_new_dn, "results/comparison/top25_new_down.tsv")

cat("Wrote top gene tables.\n")
