library(gridExtra)

### 2) Example: Compute Metrics vs Dragen ----
# We'll define a small helper function that counts TP, FP, FN, then calculates precision, recall, F1.
compute_metrics <- function(df, tool_col = "umccr", gt_col = "dragen") {
  # df      = data frame containing the columns
  # tool_col = name of the tool column, e.g. "umccr", "hmf"
  # gt_col   = name of the ground truth column, e.g. "dragen"
  
  # For each row:
  #  True Positive (TP) = ground_truth=TRUE & tool=TRUE
  #  False Positive (FP)= ground_truth=FALSE & tool=TRUE
  #  False Negative (FN)= ground_truth=TRUE & tool=FALSE
  #  (We ignore True Negatives for typical variant calling metrics.)
  
  tp <- sum(df[[gt_col]] & df[[tool_col]])
  fp <- sum(!df[[gt_col]] & df[[tool_col]])
  fn <- sum(df[[gt_col]] & !df[[tool_col]])
  
  precision <- tp / (tp + fp)
  recall    <- tp / (tp + fn)
  f1        <- 2 * (precision * recall) / (precision + recall)
  
  tibble(
    TP = tp,
    FP = fp,
    FN = fn,
    precision = precision,
    recall = recall,
    f1 = f1
  )
}

### 3) Summaries by Variant Category ----
# We'll build two data frames: metrics for UMCCR and HMF.
# Then we'll join them into one final table.

df_umccr <- sites_pass %>%
  group_by(variant_category) %>%
  summarise(
    TP       = sum(dragen & umccr),
    FP       = sum(!dragen & umccr),
    FN       = sum(dragen & !umccr),
    precision = TP / (TP + FP),
    recall    = TP / (TP + FN),
    f1        = 2 * (precision * recall) / (precision + recall)
  ) %>%
  rename_with(~paste0(.x, "_umccr"), c("TP", "FP", "FN", "precision", "recall", "f1"))

df_hmf <- sites_pass %>%
  group_by(variant_category) %>%
  summarise(
    TP       = sum(dragen & hmf),
    FP       = sum(!dragen & hmf),
    FN       = sum(dragen & !hmf),
    precision = TP / (TP + FP),
    recall    = TP / (TP + FN),
    f1        = 2 * (precision * recall) / (precision + recall)
  ) %>%
  rename_with(~paste0(.x, "_hmf"), c("TP", "FP", "FN", "precision", "recall", "f1"))

# Combine them side by side (inner join on variant_category)
final_table <- df_umccr %>%
  inner_join(df_hmf, by = "variant_category")

### 4) Add Dragen Reference ----
# Include Dragen counts for SNP and INDEL directly
final_table <- final_table %>%
  mutate(
    Dragen_SNP = if_else(variant_category == "SNP", sum(sites_pass$dragen & sites_pass$variant_category == "SNP"), NA_integer_),
    Dragen_Indel = if_else(variant_category == "Indel", sum(sites_pass$dragen & sites_pass$variant_category == "Indel"), NA_integer_),
    Dragen_SV = if_else(variant_category == "Structural Variant", sum(sites_pass$dragen & sites_pass$variant_category == "Structural Variant"), NA_integer_)
  )

final_table

  upset(
    fromList(myList),
    sets = c("hmf", "umccr", "dragen"),
    order.by = "degree",
    number.angles = 30,
    mainbar.y.label = "Shared Variants",
    keep.order = TRUE,
    sets.bar.color = c("#F8766D", "#F8766D", "#619CFF"),
    sets.x.label = "Variant Membership",
    
  )
)
