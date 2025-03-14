# Reference Sequence Comparison 


We want assess whether reference choice impacts alignment quality and variant calling for DRAGEN and Oncoanalyser pipeline.


- [documentation](/doc/) to generate data
  - 1 [Build Dragen reference](doc/Build_dragen_reference.md)
  - 2 [Dragen aligment](/doc/DRAGEN_ALIGEMENT.md)
  - 3 [Run Oncoanalyser](/doc/run_oncoanalyser.md)
  - 4 [Analysis](/doc/analysis.md)
- relevant output [data](/data/)
- [scripts](/scripts/) to make figure
- [presentation](https://unimelbcloud-my.sharepoint.com/:p:/r/personal/quentin_clayssen_unimelb_edu_au/Documents/aligment_reference_comparison_presentation.pptx?d=wcea70cb062a14e0681659b36c862b335&csf=1&web=1&e=pFtSSK) for progress summary
## ICAV2
pipeline will be launch from [ICAV2](https://github.com/umccr/wiki/blob/main/computing/cloud/illumina/icav2.md)
to connect

```bash
icav2 tenants enter umccr-prod
icav2 projects enter hmf-reference-testing-dev
```

to gain aws credential

```bash

icav2 projectdata temporarycredentials /quentin/ \
  --output-format=json | \
jq --raw-output \
  '
    .awsTempCredentials |
    [
      "export AWS_ACCESS_KEY_ID=\"\(.accessKey)\"",
      "export AWS_SECRET_ACCESS_KEY=\"\(.secretKey)\"",
      "export AWS_SESSION_TOKEN=\"\(.sessionToken)\""
    ][]
  '
```