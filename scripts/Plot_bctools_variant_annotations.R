# Load required libraries
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

if (!require("VariantAnnotation")) {
  BiocManager::install("VariantAnnotation")
}
library(VariantAnnotation)
library(dplyr)
library(ggplot2)

setwd("workspace/dragen_refer_bench/comparison/")

# Define file paths for the private VCF files produced by bcftools isec:
vcf_file_dragen <- "output_bcftools/purple_somatic_dragen_hmf/0000.vcf"  # Private to dragen/purple
vcf_file_hmf    <- "output_bcftools/purple_somatic_dragen_hmf/0001.vcf"  # Private to hmf/purple

genome_build <- "hg38"
vcf_dragen <- readVcf(vcf_file_dragen, genome_build)
vcf_hmf    <- readVcf(vcf_file_hmf, genome_build)

# Function to extract variant basic info (chromosome, position, ref, alt)
# and selected INFO fields (HOTSPOT, CLNSIG, TIER) from a VCF object.
extract_variant_df <- function(vcf_obj) {
  vr <- rowRanges(vcf_obj)
  df <- data.frame(
    CHROM = as.character(seqnames(vr)),
    POS = start(vr),
    REF = as.character(ref(vcf_obj)),
    ALT = sapply(alt(vcf_obj), function(x) paste(as.character(x), collapse=",")),
    stringsAsFactors = FALSE
  )
  
  info_df <- as.data.frame(info(vcf_obj))
  for (fld in c("HOTSPOT", "CLNSIG", "TIER")) {
    if (!fld %in% colnames(info_df)) {
      warning(sprintf("INFO field '%s' not found in VCF. Creating as NA.", fld))
      info_df[[fld]] <- NA
    }
  }
  
  df <- cbind(df, info_df[, c("HOTSPOT", "CLNSIG", "TIER"), drop = FALSE])
  df <- df %>% mutate(variant_id = paste(CHROM, POS, REF, ALT, sep = "_"))
  return(df)
}


summarize_unique_annotations <- function(df, source_label) {
  df %>%
    mutate(
      # Replace any value that is an empty character vector with "unannotated"
      CLNSIG = sapply(CLNSIG, function(x) {
        if (length(x) == 0) "unannotated" else as.character(x)
      }),
      TIER = sapply(TIER, function(x) {
        if (length(x) == 0 || x == "") "Missing" else as.character(x)
      })
    ) %>%
    group_by(CLNSIG, TIER) %>%
    summarise(Count = n(), .groups = "drop") %>%
    mutate(Source = source_label)
}

# Create data frames for each VCF file.
df_dragen <- extract_variant_df(vcf_dragen)
df_hmf    <- extract_variant_df(vcf_hmf)

# Inspect the first few rows
head(df_dragen)
head(df_hmf)

# Identify variants unique to each dataset.
unique_dragen <- anti_join(df_dragen, df_hmf, by = "variant_id")
unique_hmf    <- anti_join(df_hmf, df_dragen, by = "variant_id")

unique_counts <- data.frame(
  Source = c("dragen", "hmf"),
  Unique_Variant_Count = c(nrow(unique_dragen), nrow(unique_hmf))
)
print("Overall Unique Variant Counts:")
print(unique_counts)

# Modify the summary function to replace NA or empty values.
summarize_unique_annotations <- function(df, source_label) {
  df %>%
    mutate(
      CLNSIG = ifelse(is.na(CLNSIG) | CLNSIG == "", "Missing", as.character(CLNSIG)),
      TIER   = ifelse(is.na(TIER) | TIER == "", "Missing", as.character(TIER))
    ) %>%
    group_by(CLNSIG, TIER) %>%
    summarise(Count = n(), .groups = "drop") %>%
    mutate(Source = source_label)
}
unique_dragen_summary |> mutate(., character(0), "unattoted")
unique_dragen_summary <- summarize_unique_annotations(unique_dragen, "dragen")
unique_hmf_summary    <- summarize_unique_annotations(unique_hmf, "hmf")

combined_unique_summary <- bind_rows(unique_dragen_summary, unique_hmf_summary)
print("Summary of Unique Variants by CLNSIG and TIER:")
print(combined_unique_summary)

# Only plot if the summary table is non-empty.
if(nrow(combined_unique_summary) > 0) {
  plot_unique_summary <- function(summary_df, field1 = "CLNSIG", field2 = "TIER") {
    ggplot(summary_df, aes_string(x = field1, y = "Count", fill = "Source")) +
      geom_bar(stat = "identity", position = position_dodge(), na.rm = TRUE) +
      facet_wrap(as.formula(paste("~", field2))) +
      theme_minimal() +
      labs(title = "Unique Variants: CLNSIG and TIER Summary",
           x = field1,
           y = "Variant Count")
  }
  
  p_unique <- plot_unique_summary(combined_unique_summary)
  print(p_unique)
} else {
  message("The combined unique summary is empty; nothing to plot.")
}

unique_dragen_summary <- summarize_unique_annotations(unique_dragen, "dragen")
unique_hmf_summary    <- summarize_unique_annotations(unique_hmf, "hmf")
combined_unique_summary <- bind_rows(unique_dragen_summary, unique_hmf_summary)
print(combined_unique_summary)



# Function to summarize the HOTSPOT field for unique variants,
# replacing missing or empty values with "unannotated".
summarize_hotspot_annotations <- function(df, source_label) {
  df %>%
    mutate(
      HOTSPOT = sapply(HOTSPOT, function(x) {
        if (length(x) == 0 || x == "") "unannotated" else as.character(x)
      })
    ) %>%
    group_by(HOTSPOT) %>%
    summarise(Count = n(), .groups = "drop") %>%
    mutate(Source = source_label)
}

# Create hotspot summary tables for each source.
unique_dragen_hotspot <- summarize_hotspot_annotations(unique_dragen, "dragen")
unique_hmf_hotspot    <- summarize_hotspot_annotations(unique_hmf, "hmf")

# Combine the two summaries into one table.
combined_unique_hotspot <- bind_rows(unique_dragen_hotspot, unique_hmf_hotspot)

# For a clean, presentation-ready output, use knitr::kable (or gt if preferred)
if (!require("knitr")) install.packages("knitr")
library(knitr)

# Optionally, sort the table for readability.
simple_hotspot_summary <- combined_unique_hotspot %>%
  arrange(Source, HOTSPOT)

# Print the simplified hotspot summary table.
kable(simple_hotspot_summary,
      format = "markdown",   # Change to "html" if needed.
      caption = "Unique Variants Summary by HOTSPOT")



if (!require("ggalluvial")) install.packages("ggalluvial")
  library(ggalluvial)
  library(ggplot2)




# Create the summary table (if not already available)
df_summary <- data.frame(
  CLNSIG = c("Benign", "unannotated", "unannotated", "unannotated", "unannotated"),
  TIER = c("HIGH_CONFIDENCE", "HIGH_CONFIDENCE", "LOW_CONFIDENCE", "HIGH_CONFIDENCE", "LOW_CONFIDENCE"),
  Count = c(2, 25, 9, 21, 10),
  Source = c("dragen", "dragen", "dragen", "hmf", "hmf"),
  stringsAsFactors = FALSE
)

# Assume combined_unique_summary is already generated.
# For example, it might look like:
#   CLNSIG       TIER            Count Source
# 1 Benign       HIGH_CONFIDENCE     2 dragen
# 2 unannotated  HIGH_CONFIDENCE    25 dragen
# 3 unannotated  LOW_CONFIDENCE      9 dragen
# 4 unannotated  HIGH_CONFIDENCE    21 hmf
# 5 unannotated  LOW_CONFIDENCE     10 hmf

# First, update the TIER values for readability.
combined_unique_summary <- combined_unique_summary %>%
  mutate(TIER = case_when(
    TIER == "HIGH_CONFIDENCE" ~ "high confidence",
    TIER == "LOW_CONFIDENCE"  ~ "low confidence",
    TRUE ~ TIER
  ))

# Optionally, check the updated table:
print(combined_unique_summary)

# Create the alluvial plot:
ggplot(combined_unique_summary,
  aes(axis1 = Source, axis2 = TIER, axis3 = CLNSIG, y = Count)) +
scale_x_discrete(limits = c("Source", "Confidence", "CLNSIG"),
              expand = c(.1, .05),
              labels = c("Source", "Confidence", "CLNSIG")) +
# Remove the y-axis label by setting it to blank
ylab("") +
ggtitle("Alluvial Diagram: Unique Variants Summary") +
geom_alluvium(aes(fill = TIER),
           width = 1/12,
           alpha = 0.8) +
geom_stratum(width = 1/12, fill = "grey", color = "black") +
# Add text labels with both the category (stratum) and the count value.
geom_text(stat = "stratum",
       aes(label = paste(after_stat(stratum), "\n(", after_stat(count), ")", sep = "")),
       size = 3, color = "black") +
# Remove y-axis tick marks and labels
scale_y_continuous(labels = NULL) +
theme_minimal() +
theme(
   axis.text.y  = element_blank(),
   axis.ticks.y = element_blank())
