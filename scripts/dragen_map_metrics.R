# Load necessary libraries
library(tidyverse)
library(jsonlite)



map_metrics_dragen <- read_tsv("workspace/dragen_refer_bench/comparison/dragen/dragen/dragen_map_metrics.txt")
map_metrics_umccr  <- read_tsv("workspace/dragen_refer_bench/comparison/umccr/dragen/dragen_map_metrics.txt")
map_metrics_hmf    <- read_tsv("workspace/dragen_refer_bench/comparison/hmf/dragen/dragen_map_metrics.txt")

map_metrics_combined <- bind_rows(
  map_metrics_dragen %>% mutate(Reference = "dragen"),
  map_metrics_umccr  %>% mutate(Reference = "umccr"),
  map_metrics_hmf    %>% mutate(Reference = "hmf")
)



df_filtered <- map_metrics_combined %>%
  select(
    Reference,
    Sample,
    `Number of duplicate marked reads`,
    `Mapped reads`,
    `Unmapped reads`,
    `Soft-clipped bases`
  )


# Extract dragen baseline row
df_dragen <- df_filtered %>%
  filter(Reference == "dragen")

# Compare metrics for 'umccr' and 'hmf' to 'dragen'
df_comparison <- df_filtered %>%
  filter(Reference != "dragen") %>%
  mutate(
    pct_change_dups = (`Number of duplicate marked reads` - df_dragen$`Number of duplicate marked reads`) /
      df_dragen$`Number of duplicate marked reads` * 100,
    pct_change_mapped = (`Mapped reads` - df_dragen$`Mapped reads`) /
      df_dragen$`Mapped reads` * 100,
    pct_change_unmapped = (`Unmapped reads` - df_dragen$`Unmapped reads`) /
      df_dragen$`Unmapped reads` * 100,
    pct_change_soft_clipped = (`Soft-clipped bases` - df_dragen$`Soft-clipped bases`) /
      df_dragen$`Soft-clipped bases` * 100
  )

df_comparison


df_avg <- df_filtered %>%
  group_by(Reference) %>%
  summarize(
    dup_reads = mean(`Number of duplicate marked reads`, na.rm = TRUE),
    mapped    = mean(`Mapped reads`, na.rm = TRUE),
    unmapped  = mean(`Unmapped reads`, na.rm = TRUE),
    soft_clip = mean(`Soft-clipped bases`, na.rm = TRUE)
  )

df_dragen_avg <- df_avg %>%
  filter(Reference == "dragen")

df_comparison_avg <- df_avg %>%
  filter(Reference != "dragen") %>%
  mutate(
    pct_change_dups = (dup_reads - df_dragen_avg$dup_reads) / df_dragen_avg$dup_reads * 100,
    pct_change_mapped = (mapped - df_dragen_avg$mapped) / df_dragen_avg$mapped * 100,
    pct_change_unmapped = (unmapped - df_dragen_avg$unmapped) / df_dragen_avg$unmapped * 100,
    pct_change_soft_clipped = (soft_clip - df_dragen_avg$soft_clip) / df_dragen_avg$soft_clip * 100
  )

df_comparison_avg


df_long <- df_comparison %>%
  select(Reference,
         pct_change_dups,
         pct_change_mapped,
         pct_change_unmapped,
         pct_change_soft_clipped) %>%
  pivot_longer(
    cols = starts_with("pct_change_"),
    names_to = "Metric",
    values_to = "PctChange"
  ) %>%
  # Optional: create cleaner labels
  mutate(Metric = recode(Metric,
                         "pct_change_dups" = "Duplicate Marked Reads",
                         "pct_change_mapped" = "Mapped Reads",
                         "pct_change_unmapped" = "Unmapped Reads",
                         "pct_change_soft_clipped" = "Soft-clipped Bases"
  ))


ggplot(df_long, aes(x = Metric, y = PctChange, fill = Reference)) +
  geom_bar(stat = "identity", position = position_dodge()) +
  theme_minimal() +
  labs(
    title = "Percentage Change vs. Dragen Baseline",
    x = "Metric",
    y = "Percentage Change (%)"
  ) +
  # Show a reference line at 0% change
  geom_hline(yintercept = 0, color = "black", linetype = "dashed") +
  geom_text(aes(label=PctChange), vjust=0) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

