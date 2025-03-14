
# Build dragen reference

from [slack](https://umccr.slack.com/archives/C025TLC7D/p1733870351404989?thread_ts=1733789008.746839&cid=C025TLC7D)
[ICA](https://ica.illumina.com/ica/projects/c6dced14-0a86-487c-8e82-c82064105982/data)
I've created an example analysis with the following steps:**Presteps**

- Create the project, it's AWS S3 root URI is `[s3://pipeline-dev-cache-503977275616-ap-southeast-2/byob-icav2/hmf-reference-testing-dev/](s3://pipeline-dev-cache-503977275616-ap-southeast-2/byob-icav2/hmf-reference-testing-dev/)` , this root URI will map to `[icav2://hmf-reference-testing-dev/](icav2://hmf-reference-testing-dev/)`
- Added in the Illumina Development Services User to the project (in case we wanted to kick off anything through Orcabus)
- Added in the SQS notification queue so project failures show up on the _alerts-dev_ Slack channel
- Add the [dragen build reference tarball workflow](https://github.com/umccr/cwl-ica/releases/tag/dragen-build-reference-tarball-pipeline%2F4.2.4__20241210072731) to the project _hmf-reference-testing-dev_

**Analysis Creation Steps**

1. Enter the project context
```bash
icav2 tenants enter umccr-prod
icav2 projects enter hmf-reference-testing-dev

```


2. Create the WES Input Template
```bash 
# The pipeline id - check the CWL-ICA link above
# One can 'clone' this pipeline in the UI and then edit the copy in the UI if need be
pipeline_id="5b00a816-3adc-443d-a7a1-e2e1f038c1e8"  

# Name of workflow run
workflow_run_name="create-dragen-ref"

# Analysis output, maps to [icav2://hmf-reference-testing-dev/analysis/create-dragen-ref/](icav2://hmf-reference-testing-dev/analysis/create-dragen-ref/)
	analysis_output_uri="[s3://pipeline-dev-cache-503977275616-ap-southeast-2/byob-icav2/hmf-reference-testing-dev/analysis/create-dragen-ref/](s3://pipeline-dev-cache-503977275616-ap-southeast-2/byob-icav2/hmf-reference-testing-dev/analysis/create-dragen-ref/)"  

# Logs output, maps to [icav2://hmf-reference-testing-dev/logs/create-dragen-ref/](icav2://hmf-reference-testing-dev/logs/create-dragen-ref/)
# Not yet functional due to Illumina bug, but required by our CLI for future proofing
ica_logs_uri="[s3://pipeline-dev-cache-503977275616-ap-southeast-2/byob-icav2/hmf-reference-testing-dev/logs/create-dragen-ref/](s3://pipeline-dev-cache-503977275616-ap-southeast-2/byob-icav2/hmf-reference-testing-dev/logs/create-dragen-ref/)"

icav2 projectpipelines create-wes-input-template \
  --pipeline "${pipeline_id}" \
  --user-reference "${workflow_run_name}" \
  --analysis-output "${analysis_output_uri}" \
--ica-logs "${ica_logs_uri}" \
--output-template-yaml-path launch-dragen-ref-template.yaml

```


This yields the following snippet
can be found in the [github dragen build reference YAML](https://github.com/umccr/cwl-ica/releases/tag/dragen-build-reference-tarball-pipeline/4.2.4__20241210072731)


Then need to perform the following steps:

1. Comment out all parameters we're not going to use.
2. Comment out the _cwltool_overrides_ if we don't need them (we dont)
3. Update the parameters we are going to use.
    1. Locations can be in the format s3:// or icav2:// using the mapping
    2. Some parameters require 'secondaryFiles', this is something I need to fix on the template creation side
    3. Mapping between icav2:// uris and s3:// uris is only possible if the user was present when the storageCredentials was last 'shared'. As such you may need to use icav2 uris only for now until Florian reshares the storage credentials with the tenant.

Which gives us the following (edited )
```YAML
user_reference: create-dragen-ref-umccr
inputs:
  enable_cnv: true
  ht_reference:
    class: File
    location: icav2://hmf-reference-testing-dev/quentin/genomes/GRCh38_full_analysis_set_plus_decoy_hla.fa
    secondaryFiles:
      - class: File
        location: icav2://hmf-reference-testing-dev/quentin/genomes/GRCh38_full_analysis_set_plus_decoy_hla.fa.fai
  output_directory: ref-hmf
engine_parameters:
  pipeline: 5b00a816-3adc-443d-a7a1-e2e1f038c1e8
  analysis_output: icav2://hmf-reference-testing-dev/quentin/analysis/create-dragen-ref/umccr/
  ica_logs: icav2://hmf-reference-testing-dev/quentin/logs/create-dragen-ref/umccr/
```


We can then launch this analysis with

icav2 projectpipelines start-wes --launch-yaml launch-dragen-ref-template.yaml



I launched this as a test run last night, so you can see the outputs in the AWS CLI,

export AWS_PROFILE='umccr-development'

aws s3 ls [s3://pipeline-dev-cache-503977275616-ap-southeast-2/byob-icav2/hmf-reference-testing-dev/analysis/create-dragen-ref/](s3://pipeline-dev-cache-503977275616-ap-southeast-2/byob-icav2/hmf-reference-testing-dev/analysis/create-dragen-ref/)



## for HMF

from Genome
**s3://umccr-refdata-dev/workflow_data/genomes/GRCh38_hmf/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna**

```YAML
user_reference: create-dragen-ref-hmf
inputs:
  enable_cnv: true
  ht_reference:
    class: File
    location: icav2://hmf-reference-testing-dev/quentin/genomes/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna
    secondaryFiles:
      - class: File
        location: icav2://hmf-reference-testing-dev/quentin/genomes/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.fai
  output_directory: ref-hmf-GCA_000001405.15
engine_parameters:
  pipeline: 5b00a816-3adc-443d-a7a1-e2e1f038c1e8
  analysis_output: icav2://hmf-reference-testing-dev/quentin/analysis/create-dragen-ref/hmf/
  ica_logs: icav2://hmf-reference-testing-dev/quentin/logs/create-dragen-ref/hmf/
```


