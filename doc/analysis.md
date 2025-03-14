## DWL

```bash
# Multiqc Metrics
aws s3 cp s3://umccr-temp-dev/temp_data/COLO829v003/dragen/alignment-COLO829/COLO829_tumor__COLO829_normal_dragen_somatic_and_germline_multiqc/COLO829_tumor__COLO829_normal_dragen_somatic_and_germline_multiqc_data/dragen_map_metrics.txt dragen/dragen/dragen_map_metrics.txt

aws s3 cp s3://umccr-temp-dev/temp_data/COLO829v003/dragen/lignment-COLO829-hmf-GCA_000001405.15-ref/COLO829_tumor__COLO829_normal_dragen_somatic_and_germline_multiqc/COLO829_tumor__COLO829_normal_dragen_somatic_and_germline_multiqc_data/dragen_map_metrics.txt hmf/dragen/dragen_map_metrics.txt


aws s3 cp s3://umccr-temp-dev/temp_data/COLO829v003/dragen/alignment-COLO829-hmf-ref/COLO829_tumor__COLO829_normal_dragen_somatic_and_germline_multiqc/COLO829_tumor__COLO829_normal_dragen_somatic_and_germline_multiqc_data/dragen_map_metrics.txt umccr/dragen/dragen_map_metrics.txt


#Oncoanalysier purple
aws s3 sync s3://umccr-temp-dev/temp_data/COLO829/oncoanalyser/20250121qn26qo0z_oob/results/COLO829_COLO829v003T/purple/ dragen/purple/

aws s3 sync s3://umccr-temp-dev/temp_data/COLO829/oncoanalyser/20250121icyys2bl_oob/results/COLO829_COLO829v003T/purple/ umccr/purple/

 aws s3 sync s3://umccr-temp-dev/temp_data/COLO829/oncoanalyser/2025012269ct0204_oob/results/COLO829_COLO829v003T/purple/ hmf/purple/

#DRAGEN hardfiltred somatic

aws s3 cp s3://umccr-temp-dev/temp_data/COLO829v003/dragen/alignment-COLO829/COLO829_tumor_dragen_somatic/COLO829_tumor.hard-filtered.vcf.gz dragen/dragen/COLO829_tumor.hard-filtered.vcf.gz

aws s3 cp s3://umccr-temp-dev/temp_data/COLO829v003/dragen/alignment-COLO829-hmf-ref/COLO829_tumor_dragen_somatic/COLO829_tumor.hard-filtered.vcf.gz  umccr/dragen/dragen_umccr_COLO829_tumor.hard-filtered.vcf.gz

aws s3 cp s3://umccr-temp-dev/temp_data/COLO829v003/dragen/lignment-COLO829-hmf-GCA_000001405.15-ref/COLO829_tumor_dragen_somatic/COLO829_tumor.hard-filtered.vcf.gz hmf/dragen/dragen_hmf_COLO829_tumor.hard-filtered.vcf.gz


#DRAGEN hardfiltred 

aws s3 cp s3://umccr-temp-dev/temp_data/COLO829v003/dragen/alignment-COLO829/COLO829_normal_dragen_germline/COLO829_normal.hard-filtered.vcf.gz dragen/dragen/COLO829_normal.hard-filtered.vcf.gz

aws s3 cp s3://umccr-temp-dev/temp_data/COLO829v003/dragen/alignment-COLO829-hmf-ref/COLO829_normal_dragen_germline/COLO829_normal.hard-filtered.vcf.gz  umccr/dragen/dragen_umccr_COLO829_normal.hard-filtered.vcf.gz

aws s3 cp s3://umccr-temp-dev/temp_data/COLO829v003/dragen/lignment-COLO829-hmf-GCA_000001405.15-ref/COLO829_normal_dragen_germline/COLO829_normal.hard-filtered.vcf.gz hmf/dragen/dragen_hmf_COLO829_normal.hard-filtered.vcf.gz



#DRAGEN targeted


aws s3 cp s3://umccr-temp-dev/temp_data/COLO829v003/dragen/alignment-COLO829/COLO829_normal_dragen_germline/COLO829_normal.targeted.vcf.gz dragen/dragen/

aws s3 cp s3://umccr-temp-dev/temp_data/COLO829v003/dragen/alignment-COLO829-hmf-ref/COLO829_normal_dragen_germline/COLO829_normal.targeted.vcf.gz  umccr/dragen/

aws s3 cp s3://umccr-temp-dev/temp_data/COLO829v003/dragen/lignment-COLO829-hmf-GCA_000001405.15-ref/COLO829_normal_dragen_germline/COLO829_normal.targeted.vcf.gz hmf/dragen/

#DRAGEN multiqc
aws s3 cp s3://umccr-temp-dev/temp_data/COLO829v003/dragen/alignment-COLO829/COLO829_tumor__COLO829_normal_dragen_somatic_and_germline_multiqc/COLO829_tumor__COLO829_normal_dragen_somatic_and_germline_multiqc_data/dragen_map_metrics.txt dragen/dragen/dragen_map_metrics.txt

aws s3 cp s3://umccr-temp-dev/temp_data/COLO829v003/dragen/lignment-COLO829-hmf-GCA_000001405.15-ref/COLO829_tumor__COLO829_normal_dragen_somatic_and_germline_multiqc/COLO829_tumor__COLO829_normal_dragen_somatic_and_germline_multiqc_data/dragen_map_metrics.txt hmf/dragen/dragen_map_metrics.txt


aws s3 cp s3://umccr-temp-dev/temp_data/COLO829v003/dragen/alignment-COLO829-hmf-ref/COLO829_tumor__COLO829_normal_dragen_somatic_and_germline_multiqc/COLO829_tumor__COLO829_normal_dragen_somatic_and_germline_multiqc_data/dragen_map_metrics.txt umccr/dragen/dragen_map_metrics.txt


aws s3 cp s3://umccr-temp-dev/temp_data/COLO829v003/dragen/alignment-COLO829/COLO829_tumor__COLO829_normal_dragen_somatic_and_germline_multiqc/COLO829_tumor__COLO829_normal_dragen_somatic_and_germline_multiqc_data/multiqc_data.json dragen/dragen/

aws s3 cp s3://umccr-temp-dev/temp_data/COLO829v003/dragen/lignment-COLO829-hmf-GCA_000001405.15-ref/COLO829_tumor__COLO829_normal_dragen_somatic_and_germline_multiqc/COLO829_tumor__COLO829_normal_dragen_somatic_and_germline_multiqc_data/multiqc_data.json hmf/dragen/


aws s3 cp s3://umccr-temp-dev/temp_data/COLO829v003/dragen/alignment-COLO829-hmf-ref/COLO829_tumor__COLO829_normal_dragen_somatic_and_germline_multiqc/COLO829_tumor__COLO829_normal_dragen_somatic_and_germline_multiqc_data/multiqc_data.json umccr/dragen/


#DRAGEN multiqc
aws s3 cp s3://umccr-temp-dev/temp_data/COLO829v003/dragen/alignment-COLO829/COLO829_tumor__COLO829_normal_dragen_somatic_and_germline_multiqc/COLO829_tumor__COLO829_normal_dragen_somatic_and_germline_multiqc.html dragen/dragen/

aws s3 cp s3://umccr-temp-dev/temp_data/COLO829v003/dragen/lignment-COLO829-hmf-GCA_000001405.15-ref/COLO829_tumor__COLO829_normal_dragen_somatic_and_germline_multiqc/COLO829_tumor__COLO829_normal_dragen_somatic_and_germline_multiqc.html hmf/dragen/


aws s3 cp s3://umccr-temp-dev/temp_data/COLO829v003/dragen/alignment-COLO829-hmf-ref/COLO829_tumor__COLO829_normal_dragen_somatic_and_germline_multiqc/COLO829_tumor__COLO829_normal_dragen_somatic_and_germline_multiqc.html umccr/dragen/

```


## "VCF_STUFF"
edit linge 174 vcf.smk : tumor_sample = "COLO829_tumor"

```
eval_vcf dragen/dragen/COLO829_tumor_hard_filtered.vcf.gz          umccr/dragen/dragen_umccr_COLO829_tumor_hard_filtered.vcf.gz          hmf/dragen/dragen_hmf_COLO829_tumor_hard_filtered.vcf.gz          --ref-fasta genomes/GRCh38_full_analysis_set_plus_decoy_hla.fa          -o eval_vcf_dragen_tumor          -tn COLO829_tumor          -nn COLO829_normal

```


|                                              |        |     |       |                    |                    |                    |       |       |       |                    |                    |                    |
| -------------------------------------------- | ------ | --- | ----- | ------------------ | ------------------ | ------------------ | ----- | ----- | ----- | ------------------ | ------------------ | ------------------ |
| **Sample**                                   | SNP    | SNP | SNP   | SNP                | SNP                | SNP                | INDEL | INDEL | INDEL | INDEL              | INDEL              | INDEL              |
|                                              | TP     | FP  | FN    | Recall             | Prec               | F2                 | TP    | FP    | FN    | Recall             | Prec               | F2                 |
| **dragen_hmf_COLO829_tumor_hard_filtered**   | 334504 | 185 | 11547 | 0.9666320860220030 | 0.9994472480422120 | 0.9730215900582530 | 48346 | 40    | 29590 | 0.6203295011291320 | 0.9991733145951310 | 0.6712298336711740 |
| **dragen_umccr_COLO829_tumor_hard_filtered** | 334565 | 0   | 11486 | 0.9668083606173660 | 1.0                | 0.9732692409509360 | 48365 | 0     | 29571 | 0.6205732909053580 | 1.0                | 0.6715327859064890 |


## BCFTOOLS ISEC


```
bcftools isec dragen/dragen/COLO829_normal.hard-filtered.vcf.gz umccr/dragen/dragen_umccr_COLO829_normal.hard-filtered.vcf.gz  hmf/dragen/dragen_hmf_COLO829_normal.hard-filtered.vcf.gz -p output_bcftools/dragen_normal_hardfiltred

bcftools isec dragen/dragen/COLO829_normal.hard-filtered.vcf.gz umccr/dragen/dragen_umccr_COLO829_normal.hard-filtered.vcf.gz  hmf/dragen/dragen_hmf_COLO829_normal.hard-filtered.vcf.gz -p output_bcftools/dragen_normal_hardfiltred


bcftools isec dragen/purple/COLO829v003T.purple.somatic.vcf.gz umccr/purple/COLO829v003T.purple.somatic.vcf.gz hmf/purple/COLO829v003T.purple.somatic.vcf.gz -o output_bcftools/purple_somatic_dragen_umccr_dragen


bcftools isec dragen/dragen/COLO829_tumor.hard-filtered.vcf.gz umccr/dragen/dragen_umccr_COLO829_tumor.hard-filtered.vcf.gz hmf/dragen/dragen_hmf_COLO829_tumor.hard-filtered.vcf.gz -p output_bcftools/dragen_dragen_umccr_hmf

```







```
 bcftools view -R High-Confidence_Regions_Merged_v1.2.bed dragen/dragen/COLO829_tumor.hard-filtered.vcf.gz -o dragen/dragen/COLO829_tumor.high-confident.hard-filtered.vcf.gz -Oz


 bcftools view -R High-Confidence_Regions_Merged_v1.2.bed hmf/dragen/dragen_hmf_COLO829_tumor.hard-filtered.vcf.gz -o hmf/dragen/COLO829_tumor.high-confident.hard-filtered.vcf.gz -Oz


 bcftools view -R High-Confidence_Regions_Merged_v1.2.bed umccr/dragen/dragen_umccr_COLO829_tumor.hard-filtered.vcf.gz -o umccr/dragen/COLO829_tumor.high-confident.hard-filtered.vcf.gz -Oz
 
 
 bcftools view -H dragen/dragen/COLO829_tumor.high-confident.hard-filtered.vcf.gz | wc -l
  bcftools view -H hmf/dragen/COLO829_tumor.high-confident.hard-filtered.vcf.gz | wc -l
  bcftools view -H umccr/dragen/COLO829_tumor.high-confident.hard-filtered.vcf.gz | wc -l
  
  
bcftools isec dragen/dragen/COLO829_tumor.hard-filtered.vcf.gz umccr/dragen/dragen_umccr_COLO829_tumor.hard-filtered.vcf.gz hmf/dragen/dragen_hmf_COLO829_tumor.hard-filtered.vcf.gz -p output_bcftools/dragen_dragen_umccr_hmf_high_conf_bed -r High-Confidence_Regions_Merged_v1.2.bed


bcftools isec dragen/dragen/COLO829_normal.hard-filtered.vcf.gz umccr/dragen/dragen_umccr_COLO829_normal.hard-filtered.vcf.gz hmf/dragen/dragen_hmf_COLO829_normal.hard-filtered.vcf.gz -p output_bcftools/dragen_dragen_umccr_hmf_high_conf_bed_normal -R High-Confidence_Regions_Merged_v1.2.bed






bcftools isec dragen/dragen/COLO829_tumor.hard-filtered.vcf.gz hmf/dragen/dragen_hmf_COLO829_tumor.hard-filtered.vcf.gz -p output_bcftools/dragen_dragen_hmf_high_conf -R High-Confidence_Regions_Merged_v1.2.bed 

bcftools isec dragen/dragen/COLO829_normal.hard-filtered.vcf.gz hmf/dragen/dragen_hmf_COLO829_normal.hard-filtered.vcf.gz -p output_bcftools/dragen_dragenhmf_normal_high_conf -R High-Confidence_Regions_Merged_v1.2.bed

```




