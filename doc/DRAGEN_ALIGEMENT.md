# DRAGEN ALIGEMENT

1. Enter the project context
```bash
icav2 tenants enter umccr-prod
icav2 projects enter hmf-reference-testing-dev

```
2. Add pipeline to project
```bash
icav2 pipelines list
#find pipeline in list ""
```

3.  Download hmf COLO829 fastq and upload on ICAV2
```Bash 

https://storage.googleapis.com/hmf-public/HMFtools-Resources/dna_pipeline/test_data/COLO829v003T/fastq/COLO829v003R_AHHKYHDSXX_S13_L001_R1_001.fastq.gz
https://storage.googleapis.com/hmf-public/HMFtools-Resources/dna_pipeline/test_data/COLO829v003T/fastq/COLO829v003R_AHHKYHDSXX_S13_L001_R2_001.fastq.gz
https://storage.googleapis.com/hmf-public/HMFtools-Resources/dna_pipeline/test_data/COLO829v003T/fastq/COLO829v003R_AHHKYHDSXX_S13_L002_R1_001.fastq.gz
https://storage.googleapis.com/hmf-public/HMFtools-Resources/dna_pipeline/test_data/COLO829v003T/fastq/COLO829v003R_AHHKYHDSXX_S13_L002_R2_001.fastq.gz
https://storage.googleapis.com/hmf-public/HMFtools-Resources/dna_pipeline/test_data/COLO829v003T/fastq/COLO829v003R_AHHKYHDSXX_S13_L003_R1_001.fastq.gz
https://storage.googleapis.com/hmf-public/HMFtools-Resources/dna_pipeline/test_data/COLO829v003T/fastq/COLO829v003R_AHHKYHDSXX_S13_L003_R2_001.fastq.gz
https://storage.googleapis.com/hmf-public/HMFtools-Resources/dna_pipeline/test_data/COLO829v003T/fastq/COLO829v003R_AHHKYHDSXX_S13_L004_R1_001.fastq.gz
https://storage.googleapis.com/hmf-public/HMFtools-Resources/dna_pipeline/test_data/COLO829v003T/fastq/COLO829v003R_AHHKYHDSXX_S13_L004_R2_001.fastq.gz
https://storage.googleapis.com/hmf-public/HMFtools-Resources/dna_pipeline/test_data/COLO829v003T/fastq/COLO829v003T_AHHKYHDSXX_S12_L001_R1_001.fastq.gz
https://storage.googleapis.com/hmf-public/HMFtools-Resources/dna_pipeline/test_data/COLO829v003T/fastq/COLO829v003T_AHHKYHDSXX_S12_L001_R2_001.fastq.gz
https://storage.googleapis.com/hmf-public/HMFtools-Resources/dna_pipeline/test_data/COLO829v003T/fastq/COLO829v003T_AHHKYHDSXX_S12_L002_R1_001.fastq.gz
https://storage.googleapis.com/hmf-public/HMFtools-Resources/dna_pipeline/test_data/COLO829v003T/fastq/COLO829v003T_AHHKYHDSXX_S12_L002_R2_001.fastq.gz
https://storage.googleapis.com/hmf-public/HMFtools-Resources/dna_pipeline/test_data/COLO829v003T/fastq/COLO829v003T_AHHKYHDSXX_S12_L003_R1_001.fastq.gz
https://storage.googleapis.com/hmf-public/HMFtools-Resources/dna_pipeline/test_data/COLO829v003T/fastq/COLO829v003T_AHHKYHDSXX_S12_L003_R2_001.fastq.gz
https://storage.googleapis.com/hmf-public/HMFtools-Resources/dna_pipeline/test_data/COLO829v003T/fastq/COLO829v003T_AHHKYHDSXX_S12_L004_R1_001.fastq.gz
https://storage.googleapis.com/hmf-public/HMFtools-Resources/dna_pipeline/test_data/COLO829v003T/fastq/COLO829v003T_AHHKYHDSXX_S12_L004_R2_001.fastq.gz

for i in $(cat fastq_link.txt);do wget $i COLO829/hmf/ ; done
icav2 projectdata upload COLO829/hmf/ /quentin/fastq/



```

4. Create the WES Input Template
```bash 
# The pipeline id - check the CWL-ICA link above
# One can 'clone' this pipeline in the UI and then edit the copy in the UI if need be
pipeline_id="7d3cb608-80e0-4ecf-a67e-ef524e9bfb8b"  

# Name of workflow run
workflow_run_name="dragen-aligment-hmf-COLO829-small"

# Analysis output, maps to [icav2://hmf-reference-testing-dev/analysis/create-dragen-ref/](icav2://hmf-reference-testing-dev/analysis/dragen-aligment-hmf-custom-ref-vs-COLO829/)
	analysis_output_uri="s3://pipeline-dev-cache-503977275616-ap-southeast-2/byob-icav2/hmf-reference-testing-dev/analysis/aligment-hmf-COLO829" 

# Logs output, maps to [icav2://hmf-reference-testing-dev/logs/create-dragen-ref/](icav2://hmf-reference-testing-dev/logs/create-dragen-ref/)
# Not yet functional due to Illumina bug, but required by our CLI for future proofing
ica_logs_uri="s3://pipeline-dev-cache-503977275616-ap-southeast-2/byob-icav2/hmf-reference-testing-dev/logs/aligment-hmf-COLO829"

icav2 projectpipelines create-wes-input-template \
  --pipeline "${pipeline_id}" \
  --user-reference "${workflow_run_name}" \
  --analysis-output "${analysis_output_uri}" \
--ica-logs "${ica_logs_uri}" \
--output-template-yaml-path launch-dragen-aligment-hmf-COLO829-small.yaml

```
then edited from template

```yaml
# Name of analysis
user_reference: dragen-aligment-hmf-COLO829-small
# Inputs JSON Body
inputs:

# Booleans
    enable_hrd: true
    enable_sv_somatic: true
    cnv_use_somatic_vc_baf: true
    enable_map_align_germline: true
    enable_cnv_somatic: true
    enable_duplicate_marking: true
    enable_map_align_somatic: true
    enable_map_align_output_somatic: true
    enable_map_align_output_germline: false
    output_prefix_germline: L001
    output_prefix_somatic: L002
    reference_tar:
      class: File
      location: icav2://hmf-reference-testing-dev/analysis/create-dragen-ref-hmf/ref-test-hmf.tar.gz
    tumor_fastq_list_rows:
      - rgid: CGGAACTG.TCGTAGTG.2.241213_A00130_0352_AH3JWTDSXF.L2401760
        rgsm: L001
        rglb: L001
        lane: 2
        read_1:
          class: File
          location: icav2://hmf-reference-testing-dev/TESTX_H7YRLADXX_S1_L001_R1_001.fastq.gz
        read_2:
          class: File
          location: icav2://hmf-reference-testing-dev/TESTX_H7YRLADXX_S1_L001_R2_001.fastq.gz
    fastq_list_rows:
      - rgid: TAAGGTCA.CTACGACA.2.241209_A00130_0350_AH3L3LDSXF.L2401761
        rgsm: L002
        rglb: L002
        lane: 2
        read_1:
          class: File
          location: icav2://hmf-reference-testing-dev/TESTX_H7YRLADXX_S1_L002_R1_001.fastq.gz
        read_2:
          class: File
          location: icav2://hmf-reference-testing-dev/TESTX_H7YRLADXX_S1_L002_R2_001.fastq.gz
engine_parameters:
    pipeline: 7d3cb608-80e0-4ecf-a67e-ef524e9bfb8b  # dragen-somatic-with-germline-pipeline__4_2_4__20241210230846
    analysis_output:
        icav2://hmf-reference-testing-dev/analysis/aligment-hmf-COLO829-small/
    ica_logs:
        icav2://hmf-reference-testing-dev/logs/aligment-hmf-COLO829-small/
```

```bash
icav2 projectpipelines start-wes --launch-yaml launch-dragen-aligment-hmf-COLO829-small.yaml
```

-  result : aws s3 ls s3://pipeline-dev-cache-503977275616-ap-southeast-2/byob-icav2/hmf-reference-testing-dev/analysis/aligment-hmf-COLO829-small/

 rgsm Should be as oncoanalyser sample_id
### Dragen  COLO829 Fastq 


```yaml
# Name of analysis
user_reference: dragen-alignment-COLO829
# Inputs JSON Body
inputs:

# Booleans
    enable_hrd: true
    enable_sv_somatic: true
    cnv_use_somatic_vc_baf: true
    enable_map_align_germline: true
    enable_cnv_somatic: true
    enable_duplicate_marking: true
    enable_map_align_somatic: true
    enable_map_align_output_somatic: true
    enable_map_align_output_germline: false
    output_prefix_germline: COLO829_normal
    output_prefix_somatic: COLO829_tumor
    reference_tar:
      class: File
      location: icav2://hmf-reference-testing-dev/dragen-hash-tables/v9-r3/hg38-alt_masked-cnv-hla-rna/hg38-alt_masked.cnv.hla.rna-9-r3.0-1.tar.gz
    tumor_fastq_list_rows:
      - rgid: COLO829R_L001
        rgsm: COLO829_tumor
        rglb: COLO829_lib
        lane: 1
        read_1:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003R_AHHKYHDSXX_S13_L001_R1_001.fastq.gz
        read_2:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003R_AHHKYHDSXX_S13_L001_R2_001.fastq.gz
      - rgid: COLO829R_L002
        rgsm: COLO829_tumor
        rglb: COLO829_lib
        lane: 2
        read_1:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003R_AHHKYHDSXX_S13_L002_R1_001.fastq.gz
        read_2:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003R_AHHKYHDSXX_S13_L002_R2_001.fastq.gz
      - rgid: COLO829R_L003
        rgsm: COLO829_tumor
        rglb: COLO829_lib
        lane: 3
        read_1:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003R_AHHKYHDSXX_S13_L003_R1_001.fastq.gz
        read_2:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003R_AHHKYHDSXX_S13_L003_R2_001.fastq.gz
      - rgid: COLO829R_L004
        rgsm: COLO829_tumor
        rglb: COLO829_lib
        lane: 4
        read_1:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003R_AHHKYHDSXX_S13_L004_R1_001.fastq.gz
        read_2:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003R_AHHKYHDSXX_S13_L004_R2_001.fastq.gz
    fastq_list_rows:
      - rgid: COLO829N_L001
        rgsm: COLO829_normal
        rglb: COLO829_lib
        lane: 1
        read_1:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003T_AHHKYHDSXX_S12_L001_R1_001.fastq.gz
        read_2:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003T_AHHKYHDSXX_S12_L001_R2_001.fastq.gz
      - rgid: COLO829N_L002
        rgsm: COLO829_normal
        rglb: COLO829_lib
        lane: 2
        read_1:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003T_AHHKYHDSXX_S12_L002_R1_001.fastq.gz
        read_2:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003T_AHHKYHDSXX_S12_L002_R2_001.fastq.gz
      - rgid: COLO829N_L003
        rgsm: COLO829_normal
        rglb: COLO829_lib
        lane: 3
        read_1:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003T_AHHKYHDSXX_S12_L003_R1_001.fastq.gz
        read_2:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003T_AHHKYHDSXX_S12_L003_R2_001.fastq.gz
      - rgid: COLO829N_L004
        rgsm: COLO829_normal
        rglb: COLO829_lib
        lane: 4
        read_1:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003T_AHHKYHDSXX_S12_L004_R1_001.fastq.gz
        read_2:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003T_AHHKYHDSXX_S12_L004_R2_001.fastq.gz
engine_parameters:
    pipeline: 7d3cb608-80e0-4ecf-a67e-ef524e9bfb8b  # dragen-somatic-with-germline-pipeline__4_2_4__20241210230846
    analysis_output:
        icav2://hmf-reference-testing-dev/quentin/analysis/alignment-COLO829/
    ica_logs:
        icav2://hmf-reference-testing-dev/quentin/logs/alignment-COLO829/


```

### UMCCR COLO829 Fastq 


```yaml
# Name of analysis
user_reference: dragen-alignment-COLO829-umccr-ref
# Inputs JSON Body
inputs:

# Booleans
    enable_hrd: true
    enable_sv_somatic: true
    cnv_use_somatic_vc_baf: true
    enable_map_align_germline: true
    enable_cnv_somatic: true
    enable_duplicate_marking: true
    enable_map_align_somatic: true
    enable_map_align_output_somatic: true
    enable_map_align_output_germline: false
    output_prefix_germline: COLO829_normal
    output_prefix_somatic: COLO829_tumor
    reference_tar:
      class: File
      location: icav2://hmf-reference-testing-dev/quentin/analysis/create-dragen-ref/umccr/ref-hmf.tar.gz
    tumor_fastq_list_rows:
      - rgid: COLO829R_L001
        rgsm: COLO829_tumor
        rglb: COLO829_lib
        lane: 1
        read_1:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003R_AHHKYHDSXX_S13_L001_R1_001.fastq.gz
        read_2:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003R_AHHKYHDSXX_S13_L001_R2_001.fastq.gz
      - rgid: COLO829R_L002
        rgsm: COLO829_tumor
        rglb: COLO829_lib
        lane: 2
        read_1:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003R_AHHKYHDSXX_S13_L002_R1_001.fastq.gz
        read_2:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003R_AHHKYHDSXX_S13_L002_R2_001.fastq.gz
      - rgid: COLO829R_L003
        rgsm: COLO829_tumor
        rglb: COLO829_lib
        lane: 3
        read_1:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003R_AHHKYHDSXX_S13_L003_R1_001.fastq.gz
        read_2:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003R_AHHKYHDSXX_S13_L003_R2_001.fastq.gz
      - rgid: COLO829R_L004
        rgsm: COLO829_tumor
        rglb: COLO829_lib
        lane: 4
        read_1:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003R_AHHKYHDSXX_S13_L004_R1_001.fastq.gz
        read_2:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003R_AHHKYHDSXX_S13_L004_R2_001.fastq.gz
    fastq_list_rows:
      - rgid: COLO829N_L001
        rgsm: COLO829_normal
        rglb: COLO829_lib
        lane: 1
        read_1:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003T_AHHKYHDSXX_S12_L001_R1_001.fastq.gz
        read_2:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003T_AHHKYHDSXX_S12_L001_R2_001.fastq.gz
      - rgid: COLO829N_L002
        rgsm: COLO829_normal
        rglb: COLO829_lib
        lane: 2
        read_1:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003T_AHHKYHDSXX_S12_L002_R1_001.fastq.gz
        read_2:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003T_AHHKYHDSXX_S12_L002_R2_001.fastq.gz
      - rgid: COLO829N_L003
        rgsm: COLO829_normal
        rglb: COLO829_lib
        lane: 3
        read_1:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003T_AHHKYHDSXX_S12_L003_R1_001.fastq.gz
        read_2:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003T_AHHKYHDSXX_S12_L003_R2_001.fastq.gz
      - rgid: COLO829N_L004
        rgsm: COLO829_normal
        rglb: COLO829_lib
        lane: 4
        read_1:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003T_AHHKYHDSXX_S12_L004_R1_001.fastq.gz
        read_2:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003T_AHHKYHDSXX_S12_L004_R2_001.fastq.gz
engine_parameters:
    pipeline: 7d3cb608-80e0-4ecf-a67e-ef524e9bfb8b  # dragen-somatic-with-germline-pipeline__4_2_4__20241210230846
    analysis_output:
        icav2://hmf-reference-testing-dev/quentin/analysis/alignment-COLO829-umccr-ref/
    ica_logs:
        icav2://hmf-reference-testing-dev/quentin/logs/alignment-COLO829-umccr-ref/

```

### HMF COLO829 Fastq 


```yaml
# Name of analysis
user_reference: dragen-alignment-COLO829-hmf-GCA_000001405-15-ref
# Inputs JSON Body
inputs:

# Booleans
    enable_hrd: true
    enable_sv_somatic: true
    cnv_use_somatic_vc_baf: true
    enable_map_align_germline: true
    enable_cnv_somatic: true
    enable_duplicate_marking: true
    enable_map_align_somatic: true
    enable_map_align_output_somatic: true
    enable_map_align_output_germline: false
    output_prefix_germline: COLO829_normal
    output_prefix_somatic: COLO829_tumor
    reference_tar:
      class: File
      location: icav2://hmf-reference-testing-dev/quentin/analysis/create-dragen-ref/hmf/ref-hmf-GCA_000001405.15.tar.gz
    tumor_fastq_list_rows:
      - rgid: COLO829R_L001
        rgsm: COLO829_tumor
        rglb: COLO829_lib
        lane: 1
        read_1:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003R_AHHKYHDSXX_S13_L001_R1_001.fastq.gz
        read_2:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003R_AHHKYHDSXX_S13_L001_R2_001.fastq.gz
      - rgid: COLO829R_L002
        rgsm: COLO829_tumor
        rglb: COLO829_lib
        lane: 2
        read_1:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003R_AHHKYHDSXX_S13_L002_R1_001.fastq.gz
        read_2:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003R_AHHKYHDSXX_S13_L002_R2_001.fastq.gz
      - rgid: COLO829R_L003
        rgsm: COLO829_tumor
        rglb: COLO829_lib
        lane: 3
        read_1:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003R_AHHKYHDSXX_S13_L003_R1_001.fastq.gz
        read_2:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003R_AHHKYHDSXX_S13_L003_R2_001.fastq.gz
      - rgid: COLO829R_L004
        rgsm: COLO829_tumor
        rglb: COLO829_lib
        lane: 4
        read_1:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003R_AHHKYHDSXX_S13_L004_R1_001.fastq.gz
        read_2:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003R_AHHKYHDSXX_S13_L004_R2_001.fastq.gz
    fastq_list_rows:
      - rgid: COLO829N_L001
        rgsm: COLO829_normal
        rglb: COLO829_lib
        lane: 1
        read_1:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003T_AHHKYHDSXX_S12_L001_R1_001.fastq.gz
        read_2:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003T_AHHKYHDSXX_S12_L001_R2_001.fastq.gz
      - rgid: COLO829N_L002
        rgsm: COLO829_normal
        rglb: COLO829_lib
        lane: 2
        read_1:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003T_AHHKYHDSXX_S12_L002_R1_001.fastq.gz
        read_2:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003T_AHHKYHDSXX_S12_L002_R2_001.fastq.gz
      - rgid: COLO829N_L003
        rgsm: COLO829_normal
        rglb: COLO829_lib
        lane: 3
        read_1:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003T_AHHKYHDSXX_S12_L003_R1_001.fastq.gz
        read_2:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003T_AHHKYHDSXX_S12_L003_R2_001.fastq.gz
      - rgid: COLO829N_L004
        rgsm: COLO829_normal
        rglb: COLO829_lib
        lane: 4
        read_1:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003T_AHHKYHDSXX_S12_L004_R1_001.fastq.gz
        read_2:
          class: File
          location: icav2://hmf-reference-testing-dev/quentin/fastq/hmf/COLO829v003T_AHHKYHDSXX_S12_L004_R2_001.fastq.gz
engine_parameters:
    pipeline: 7d3cb608-80e0-4ecf-a67e-ef524e9bfb8b  # dragen-somatic-with-germline-pipeline__4_2_4__20241210230846
    analysis_output:
        icav2://hmf-reference-testing-dev/quentin/analysis/alignment-COLO829-hmf-GCA_000001405.15-ref/
    ica_logs:
        icav2://hmf-reference-testing-dev/quentin/logs/alignment-COLO829-hmf-GCA_000001405.15-ref/

```

## SANITY CHECK 

Default dragen commande used
```bash
dragen --enable-variant-caller=true --intermediate-results-dir=/scratch/intermediate-results/ --enable-duplicate-marking=true --enable-map-align=true --enable-map-align-output=false --fastq-list=fastq_list.csv --lic-instance-id
-location=/opt/instance-identity --output-directory=COLO829_normal_dragen_germline --output-file-prefix=COLO829_normal --ref-dir=/scratch/ref/hg38-alt_masked.cnv.hla.rna-9-r3.0-1/
```
Dragen hmf reference used
``` bash 
dragen --enable-variant-caller=true --intermediate-results-dir=/scratch/intermediate-results/ --enable-duplicate-marking=true --enable-map-align=true --enable-map-align-output=false --fastq-list=fastq_list.csv --lic-instance-id
-location=/opt/instance-identity --output-directory=COLO829_normal_dragen_germline --output-file-prefix=COLO829_normal --ref-dir=/scratch/ref/ref-hmf/
```
