# bioInf
Final Project Of Bioinformatics Ekaterine Tsirekidze

Reproducibility of Glucocorticoid-Induced Differential Gene Expression Using Older and Newer RNA-seq Data

Abstract

Reproducibility across independent datasets is critical for validating biological conclusions. In this project, we evaluated whether glucocorticoid-responsive transcriptional signatures identified in an older study reproduce in a newer, independent dataset. Using publicly available processed differential expression results from GEO, we compared dexamethasone-treated versus untreated samples from an older study (GSE52778) to budesonide-treated versus vehicle-treated samples from a newer RNA-seq study (GSE94335). After standardizing gene identifiers and statistical thresholds, we observed meaningful overlap between significant genes and strong concordance of effect sizes. These results demonstrate that core glucocorticoid-induced transcriptional responses remain robust across datasets, drugs, and analytical pipelines.
________________________________________
Introduction

Glucocorticoids are widely used anti-inflammatory agents that exert their effects through large-scale transcriptional regulation. Numerous studies have characterized glucocorticoid-responsive genes; however, differences in experimental design, drug choice, sequencing technology, and analysis methods raise questions about reproducibility. Older studies often used microarray or early RNA-seq approaches, while newer datasets benefit from improved sequencing depth and statistical modeling.
Here, we test whether gene expression changes identified in an older dexamethasone treatment study hold up when evaluated against a newer budesonide treatment dataset. By directly comparing processed differential expression results, we assess both the overlap of significant genes and the consistency of effect sizes.
________________________________________
Methods

Data sources

•	Older dataset: GSE52778 — dexamethasone vs untreated differential gene expression.

•	Newer dataset: GSE94335 — budesonide vs vehicle RNA-seq differential expression (non-asthma donors).

Data processing and standardization

To enable a rapid and consistent comparison, we used processed differential expression tables provided by GEO rather than reprocessing raw sequencing data. For the older dataset, gene-level log2 fold changes and q-values were directly used. For the newer dataset, transcript-level results were converted to gene-level by mapping transcript identifiers to gene symbols and retaining the most significant transcript per gene.
To enable a rapid yet consistent comparison, we used processed differential expression tables provided by GEO rather than reprocessing raw sequencing reads. Because the older dataset is reported at the gene level while the newer dataset is reported at the transcript level, a harmonization step was required.
1.	Load old and new differential expression result tables.
2.	Standardize the older dataset by extracting gene symbol, log2 fold change, and FDR-adjusted p-value into a common schema (gene, log2FC, padj).
3.	Convert the newer dataset to gene level by mapping transcripts to gene symbols and collapsing multiple transcripts per gene. For each gene, the most significant transcript (lowest FDR/q-value) was retained as the gene’s representative effect size and adjusted p-value.
4.	Apply a shared significance threshold (FDR < 0.05) to both datasets.

Reproducibility analysis

Reproducibility was quantified by:

1.	Counting significant genes in each dataset
2.	Measuring overlap of significant genes (set intersection)
3.	Computing the Jaccard index for overlap similarity
4.	Calculating Spearman correlation of log2FC values among overlapping significant genes
5.	Visualizing agreement using a log2FC scatter plot
________________________________________

Results

Differential expression and overlap

At FDR < 0.05:

•	Older dataset: 316 significant genes
•	Newer dataset: 2534 significant genes
•	Shared significant genes: 235
•	Jaccard index: 0.089
This is normal and expected as new data is much more sensitive, it’s a different drugs(same class), it’s a different experiments. Despite all this 235 genes still respond in both datasets
Effect size concordance
Among genes significant in both datasets, log2 fold changes were highly concordant, with a Spearman correlation of ρ = 0.89. This strong positive correlation indicates that not only the direction but also the magnitude of glucocorticoid-induced expression changes are conserved across studies.

Top up-regulated genes

Highly induced genes in the older dataset included VCAM1, WNT2, TSLP, PLA2G4A, and LIF, many of which are known to participate in inflammatory signaling and glucocorticoid response pathways.
In the newer dataset, strong induction was observed for TNC, IL6, VCAM1, EGR2, and TSC22D4, consistent with canonical glucocorticoid-regulated transcriptional programs.
Notably, genes such as VCAM1 and SLC14A1 appeared among the top up-regulated genes in both datasets, providing concrete examples of reproducible glucocorticoid targets.
________________________________________

Discussion

This analysis demonstrates substantial reproducibility of glucocorticoid-responsive gene expression across an older and a newer dataset. Although the newer RNA-seq study identified a larger number of significant genes—likely due to higher sensitivity and improved modeling—the strong overlap and high correlation of effect sizes indicate that core transcriptional responses are preserved.
Differences between datasets can be attributed to several factors, including the use of different glucocorticoids (dexamethasone vs budesonide), differences in sequencing platforms, and transcript-level versus gene-level analysis approaches. Nevertheless, the consistency observed here supports the robustness of key glucocorticoid-regulated pathways and validates conclusions drawn from earlier studies.
________________________________________

Conclusion

By reproducing an older study’s findings using newer data, this project shows that major glucocorticoid-responsive transcriptional signatures remain stable across time, technologies, and analytical methods. This approach highlights the value of re-evaluating established results with modern datasets to assess their robustness and biological relevance.

Link for old paper: https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSM1275862

Link for new paper: https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE94335
