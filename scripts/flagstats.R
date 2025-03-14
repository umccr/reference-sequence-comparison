library(tidyverse)
library(stringr)
library(glue)
setwd("~/workspace/dragen_refer_bench/comparison/")
# 1. Define file paths and reference names
files <- c(
  dragen = "dragen/oncoanalyser/COLO829v003R.flagstat",
  umccr = "umccr/oncoanalyser/COLO829v003R.flagstat", 
  hmf = "hmf/oncoanalyser/COLO829v003R.flagstat"
)

# 2. Create parsing function
parse_flagstat <- function(file_path, ref_name) {
  read_lines(file_path) %>% 
    tibble(raw = .) %>% 
    filter(str_detect(raw, "^\\d")) %>% # Keep lines with metrics
    mutate(
      value = as.numeric(str_extract(raw, "^\\d+")),
      metric = str_remove(raw, "^\\d+ \\+ \\d+ "),
      metric = str_remove(metric, "\\s*\\(.*\\)"),
      metric = str_trim(metric),
      reference = ref_name
    ) %>%
    select(reference, metric, value)
}

# 3. Parse all files and combine
flagstat_df <- map2_dfr(files, names(files), parse_flagstat)

# 4. Clean metric names and pivot wider
clean_metrics <- flagstat_df %>% 
  mutate(metric = case_when(
    str_detect(metric, "with mate mapped to a different chr \\(mapQ>=5\\)") ~
      "mate_diff_chr_mapQ5",
    str_detect(metric, "with mate mapped to a different chr") ~
      "mate_diff_chr",
    TRUE ~ metric
  )) %>%
  pivot_wider(names_from = reference, values_from = value)

# 5. Calculate percentage changes vs Dragen
comparison_df <- clean_metrics %>% 
  mutate(
    umccr_pct = (umccr - dragen)/dragen * 100,
    hmf_pct = (hmf - dragen)/dragen * 100
  )

# 6. Visualize key metrics
key_metrics <- c("mapped", "properly paired", "duplicates", 
                 "supplementary", "mate_diff_chr_mapQ5")

comparison_df %>% 
  filter(metric %in% key_metrics) %>% 
  pivot_longer(cols = ends_with("_pct"), names_to = "ref", values_to = "pct") %>% 
  mutate(ref = str_remove(ref, "_pct")) %>% 
  ggplot(aes(x = metric, y = pct, fill = ref)) +
  geom_col(position = position_dodge()) +
  geom_hline(yintercept = 0, linetype = "dashed") +
  geom_text(aes(label = sprintf("%.2f%%", pct)), 
            position = position_dodge(width = 0.9), 
            vjust = -0.5, size = 3) +
  labs(title = "Flagstat Metrics Comparison vs Dragen Baseline",
       subtitle = "COLO829v003R Alignment Statistics",
       y = "Percentage Change (%)", x = "") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

