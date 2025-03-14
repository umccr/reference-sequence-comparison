require(UpSetR)
require(tidyr)
require(tidyverse)
require(glue)


sites_pass_path <- "~/workspace/dragen_refer_bench/comparison/output_bcftools/dragen_dragen_umccr_hmf_high_conf_bed_normal/sites.txt"

sites_file <- read.table(
  sites_pass_path,
  header = FALSE,
  stringsAsFactors = FALSE
)
colnames(sites_file) <- c("CHROM", "POS", "REF", "ALT", "SET")


sites <- sites_file %>%
  mutate(
    dragen = SET %in% c("100", "110", "101", "111"),
    umccr  = SET %in% c("010", "110", "011", "111"),
    hmf    = SET %in% c("001", "101", "011", "111")
  )


counts <- sites %>%
  group_by(SET) %>%
  summarise(Count = n()) %>%
  ungroup()





############## PLot




sites_pass <- readr::read_tsv(
  sites_pass_path, 
  col_names = c("CHR", "POS", "REF", "ALT", "presence"), 
  col_types = cols(.default = "c")  # read everything as character initially
)

### 2) Separate the 'presence' column into three sub-columns ----
# The 'sep = c(1,2)' means:
#   - Extract the first character into 'dragen'
#   - Extract the second character into 'umccr'
#   - Extract the remaining part (third character) into 'hmf'
# This is because bcftools isec typically outputs a 3-digit bitmask (e.g. "101").
sites_pass <- sites_pass %>%
  separate(
    col  = presence,
    into = c("dragen", "umccr", "hmf"),
    sep  = c(1, 2),    # positions to split (1->2, 2->3)
    remove = TRUE      # remove the original 'presence' column
  ) %>%
  # Convert the "0"/"1" strings to integers
  mutate(
    across(c(dragen, umccr, hmf), as.integer)
  ) %>%
  # Optionally convert to TRUE/FALSE
  mutate(
    across(c(dragen, umccr, hmf), ~ . == 1)
  ) %>%
  # Add a more descriptive column (optional)
  mutate(
    vcfDescription = glue("GRCh38:{CHR}:{POS}:{REF}:{ALT}"),
    .before = CHR
  ) %>%
  as.data.frame()


sites_pass <- sites_pass %>%
  mutate(
    variant_category = case_when(
      nchar(REF) == 1 & nchar(ALT) == 1 ~ "SNP",
      nchar(REF) != nchar(ALT)         ~ "Indel",
      TRUE                             ~ "Other"
    )
  )


myList <- list(
  dragen = which(sites_pass$dragen),
  umccr  = which(sites_pass$umccr),
  hmf    = which(sites_pass$hmf)
)



 upset(
  fromList(myList),
  sets = c("hmf", "umccr", "dragen"),
  order.by = "degree",
  mainbar.y.label = "Shared Variants",
  keep.order = TRUE,
  sets.bar.color = c("#F8766D", "#F8766D", "#619CFF"),
  sets.x.label = "Alignment Metric (x10^5)",
  mb.ratio = c(0.6, 0.4)  
  )




