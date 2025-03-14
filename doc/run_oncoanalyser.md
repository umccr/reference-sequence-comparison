# Nextflow-stack 

- move data from ICAV2 to S3 dev
- activate conda env with nextflow
- edit run.sh 



## Nextflow commande



```bash
nextflow -config aws.config run /mnt/data/oncoanalyser/main.nf -ansi-log false --monochrome_logs -profile docker -work-dir 's3://umccr-temp-dev/temp_data/COLO829/oncoanalyser/20250109llo4jztq_oob/scratch/' --mode wgts --input samplesheet_default_dragen_4.2.csv --genome GRCh38_umccr --genome_version 38 --genome_type alt --force_genome --ref_data_hmf_data_path 's3://umccr-refdata-dev/workflow_data/hmf_reference_data/hmftools/5.34_38--2/' --ref_data_virusbreakenddb_path 's3://umccr-refdata-dev/workflow_data/databases/virusbreakend/virusbreakenddb_20210401/' --outdir 's3://umccr-temp-dev/temp_data/COLO829/oncoanalyser/20250113llo4jtqc_oob/results/' -resume
```


```bash
nextflow -config aws.config run /mnt/data/oncoanalyser/main.nf -ansi-log false --monochrome_logs -profile docker -work-dir 's3://umccr-temp-dev/temp_data/COLO829/oncoanalyser/2025011458e1lb68_oob/scratch/' --mode wgts --input samplesheet.csv --genome GRCh38_umccr --genome_version 38 --genome_type alt --force_genome --ref_data_hmf_data_path 's3://umccr-refdata-dev/workflow_data/hmf_reference_data/hmftools/5.34_38--2/' --ref_data_virusbreakenddb_path 's3://umccr-refdata-dev/workflow_data/databases/virusbreakend/virusbreakenddb_20210401/' --outdir 's3://umccr-temp-dev/temp_data/COLO829/oncoanalyser/2025011458e1lb68_oob/results/' -resume
```



```bash
nextflow -config aws.config run /mnt/data/oncoanalyser/main.nf -ansi-log false --monochrome_logs -profile docker -work-dir 's3://umccr-temp-dev/temp_data/COLO829/oncoanalyser/202501164y6onhon_oob/scratch/' --mode wgts --input samplesheet.csv --genome GRCh38_umccr --genome_version 38 --genome_type alt --force_genome --ref_data_hmf_data_path 's3://umccr-refdata-dev/workflow_data/hmf_reference_data/hmftools/5.34_38--2/' --ref_data_virusbreakenddb_path 's3://umccr-refdata-dev/workflow_data/databases/virusbreakend/virusbreakenddb_20210401/' --outdir 's3://umccr-temp-dev/temp_data/COLO829/oncoanalyser/202501164y6onhon_oob/results/' -resume
```

## Bash run 
``` bash
 bash run.sh  --portal_run_id "202501164y6onhon_oob" --tumor_wgs_library_id  "L2300007" --mode "wgs"   --subject_id "COLO829"   --tumor_wgs_sample_id "COLO829v003T" --tumor_wgs_sample_id "COLO829v003T"    --tumor_wgs_bam "s3://umccr-temp-dev/temp_data/COLO829v003/dragen/lignment-COLO829-hmf-GCA_000001405.15-ref/COLO829_tumor_dragen_somatic/COLO829_tumor_tumor.bam" --normal_wgs_sample_id "COLO829v003R"  --normal_wgs_library_id "L2300007"   --normal_wgs_bam "s3://umccr-temp-dev/temp_data/COLO829v003/dragen/lignment-COLO829-hmf-GCA_000001405.15-ref/COLO829_tumor_dragen_somatic/COLO829_normal_normal.bam"  --output_results_dir "s3://umccr-temp-dev/temp_data/COLO829/oncoanalyser/202501164y6onhon_oob/results/"   --output_staging_dir c202501164y6onhon_oob/staging/"    --output_scratch_dir "s3://umccr-temp-dev/temp_data/COLO829/oncoanalyser/202501164y6onhon_oob/scratch/"

```

```
ERROR	2025-01-17 08:23:24	ReferenceCommandLineProgram	Reference genome used by gridss_preprocess/COLO829v003T.sv_prep.sorted.bam.gridss.working/tmp.COLO829v003T.sv_prep.sorted.bam.namedsorted.bam does not match reference genome GRCh38_full_analysis_set_plus_decoy_hla.fa. The reference supplied must match the reference used for every input.
[Fri Jan 17 08:23:24 GMT 2025] gridss.ComputeSamTags done. Elapsed time: 0.00 minutes.
Runtime.totalMemory()=505413632
Exception in thread "main" htsjdk.samtools.util.SequenceUtil$SequenceListsDifferException: In files /fusion/s3/umccr-temp-dev/temp_data/COLO829/oncoanalyser/202501164y6onhon_oob/scratch/e5/8cf7e3fbf25ea0942521d39984b8c1/gridss_preprocess/COLO829v003T.sv_prep.sorted.bam.gridss.working/tmp.COLO829v003T.sv_prep.sorted.bam.namedsorted.bam and /fusion/s3/umccr-temp-dev/temp_data/COLO829/oncoanalyser/202501164y6onhon_oob/scratch/e5/8cf7e3fbf25ea0942521d39984b8c1/GRCh38_full_analysis_set_plus_decoy_hla.fa
	at htsjdk.samtools.util.SequenceUtil.assertSequenceDictionariesEqual(SequenceUtil.java:345)
	at gridss.cmdline.ReferenceCommandLineProgram.ensureDictionaryMatches(ReferenceCommandLineProgram.java:134)
	at gridss.cmdline.ReferenceCommandLineProgram.ensureDictionaryMatches(ReferenceCommandLineProgram.java:120)
	at gridss.ComputeSamTags.doWork(ComputeSamTags.java:103)
	at picard.cmdline.CommandLineProgram.instanceMain(CommandLineProgram.java:305)
	at gridss.ComputeSamTags.main(ComputeSamTags.java:334)
Caused by: htsjdk.samtools.util.SequenceUtil$SequenceListsDifferException: Sequence dictionaries are not the same size (195, 3366)
	at htsjdk.samtools.util.SequenceUtil.assertSequenceListsEqual(SequenceUtil.java:251)
	at htsjdk.samtools.util.SequenceUtil.assertSequenceDictionariesEqual(SequenceUtil.java:334)
	at htsjdk.samtools.util.SequenceUtil.assertSequenceDictionariesEqual(SequenceUtil.java:320)
	at htsjdk.samtools.util.SequenceUtil.assertSequenceDictionariesEqual(SequenceUtil.java:343)
```



```bash
 bash run.sh  --portal_run_id "202501200luax3cu_oob" --tumor_wgs_library_id  "L2300007" --mode "wgs"   --subject_id "COLO829"   --tumor_wgs_sample_id "COLO829v003T" --tumor_wgs_sample_id "COLO829_tumor"    --tumor_wgs_bam "s3://umccr-temp-dev/temp_data/COLO829v003/dragen/lignment-COLO829-hmf-GCA_000001405.15-ref/COLO829_tumor_dragen_somatic/COLO829_tumor_tumor.bam" --normal_wgs_sample_id "COLO829_normal"  --normal_wgs_library_id "L2300007"   --normal_wgs_bam "s3://umccr-temp-dev/temp_data/COLO829v003/dragen/lignment-COLO829-hmf-GCA_000001405.15-ref/COLO829_tumor_dragen_somatic/COLO829_normal_normal.bam"  --output_results_dir "s3://umccr-temp-dev/temp_data/COLO829/oncoanalyser/202501200luax3cu_oob/results/"   --output_staging_dir "s3://umccr-temp-dev/temp_data/COLO829/oncoanalyser/202501200luax3cu_oob/staging/"    --output_scratch_dir "s3://umccr-temp-dev/temp_data/COLO829/oncoanalyser/202501200luax3cu_oob/scratch/"
```


20250121qn26qo0z_oob


```bash
 bash run.sh  --portal_run_id "20250121qn26qo0z_oob" --tumor_wgs_library_id  "L2300007" --mode "wgs"   --subject_id "COLO829" --tumor_wgs_sample_id "COLO829v003T"    --tumor_wgs_bam "s3://umccr-temp-dev/temp_data/COLO829v003/dragen/alignment-COLO829/COLO829_tumor_dragen_somatic/COLO829_tumor_tumor.bam" --normal_wgs_sample_id "COLO829v003R"  --normal_wgs_library_id "L2300007"   --normal_wgs_bam "s3://umccr-temp-dev/temp_data/COLO829v003/dragen/alignment-COLO829/COLO829_tumor_dragen_somatic/COLO829_normal_normal.bam"  --output_results_dir "s3://umccr-temp-dev/temp_data/COLO829/oncoanalyser/20250121qn26qo0z_oob/results/"   --output_staging_dir "s3://umccr-temp-dev/temp_data/COLO829/oncoanalyser/20250121qn26qo0z_oob/staging/"    --output_scratch_dir "s3://umccr-temp-dev/temp_data/COLO829/oncoanalyser/20250121qn26qo0z_oob/scratch/"
```




20250121icyys2bl_oob

```bash
 bash run.sh  --portal_run_id "20250121icyys2bl_oob" --tumor_wgs_library_id  "L2300007" --mode "wgs"   --subject_id "COLO829" --tumor_wgs_sample_id "COLO829v003T"    --tumor_wgs_bam "s3://umccr-temp-dev/temp_data/COLO829v003/dragen/alignment-COLO829-hmf-ref/COLO829_tumor_dragen_somatic/COLO829_tumor_tumor.bam" --normal_wgs_sample_id "COLO829v003R"  --normal_wgs_library_id "L2300007"   --normal_wgs_bam "s3://umccr-temp-dev/temp_data/COLO829v003/dragen/alignment-COLO829-hmf-ref/COLO829_tumor_dragen_somatic/COLO829_normal_normal.bam"  --output_results_dir "s3://umccr-temp-dev/temp_data/COLO829/oncoanalyser/20250121icyys2bl_oob/results/"   --output_staging_dir "s3://umccr-temp-dev/temp_data/COLO829/oncoanalyser/20250121icyys2bl_oob/staging/"    --output_scratch_dir "s3://umccr-temp-dev/temp_data/COLO829/oncoanalyser/20250121icyys2bl_oob/scratch/"
```



2025012269ct0204_oob



```bash
 bash run.sh  --portal_run_id "2025012269ct0204_oob" --tumor_wgs_library_id  "L2300007" --mode "wgs"   --subject_id "COLO829" --tumor_wgs_sample_id "COLO829_tumor"    --tumor_wgs_bam "s3://umccr-temp-dev/temp_data/COLO829v003/dragen/lignment-COLO829-hmf-GCA_000001405.15-ref/COLO829_tumor_dragen_somatic/COLO829_tumor_tumor.bam" --normal_wgs_sample_id "COLO829_normal"  --normal_wgs_library_id "L2300007"   --normal_wgs_bam "s3://umccr-temp-dev/temp_data/COLO829v003/dragen/lignment-COLO829-hmf-GCA_000001405.15-ref/COLO829_tumor_dragen_somatic/COLO829_normal_normal.bam"  --output_results_dir "s3://umccr-temp-dev/temp_data/COLO829/oncoanalyser/2025012269ct0204_oob/results/"   --output_staging_dir "s3://umccr-temp-dev/temp_data/COLO829/oncoanalyser/2025012269ct0204_oob/staging/"    --output_scratch_dir "s3://umccr-temp-dev/temp_data/COLO829/oncoanalyser/2025012269ct0204_oob/scratch/"
```
error reference
```04:50:02.905 INFO  NativeLibraryLoader - Loading libgkl_compression.so from jar:file:/usr/local/share/gridss-2.13.2-3/gridss.jar!/com/intel/gkl/native/libgkl_compression.so
[Wed Jan 22 04:50:02 GMT 2025] ComputeSamTags INPUT=gridss_preprocess/COLO829v003T.sv_prep.sorted.bam.gridss.working/tmp.COLO829v003T.sv_prep.sorted.bam.namedsorted.bam OUTPUT=/dev/stdout ASSUME_SORTED=true MODIFICATION_SUMMARY_FILE=gridss_preprocess/COLO829v003T.sv_prep.sorted.bam.gridss.working/COLO829v003T.sv_prep.sorted.bam.computesamtags.changes.tsv REMOVE_TAGS=[aa] WORKER_THREADS=16 WORKING_DIR=gridss_preprocess TMP_DIR=[gridss_preprocess/COLO829v003T.sv_prep.sorted.bam.gridss.working] COMPRESSION_LEVEL=0 REFERENCE_SEQUENCE=GRCh38_full_analysis_set_plus_decoy_hla.fa    SOFTEN_HARD_CLIPS=true FIX_MATE_INFORMATION=true FIX_DUPLICATE_FLAG=true FIX_MISSING_HARD_CLIP=true RECALCULATE_SUPPLEMENTARY=true SUPPLEMENTARY_ALIGNMENT_OVERLAP_THRESHOLD=25 FIX_TERMINAL_CIGAR_INDEL=true TAGS=[R2, MQ, SA, MC, NM] IGNORE_DUPLICATES=true VERBOSITY=INFO QUIET=false VALIDATION_STRINGENCY=STRICT MAX_RECORDS_IN_RAM=500000 CREATE_INDEX=false CREATE_MD5_FILE=false GA4GH_CLIENT_SECRETS=client_secrets.json USE_JDK_DEFLATER=false USE_JDK_INFLATER=false
[Wed Jan 22 04:50:02 GMT 2025] Executing as root@ip-10-2-3-130.ap-southeast-2.compute.internal on Linux 4.14.355-275.570.amzn2.x86_64 amd64; OpenJDK 64-Bit Server VM 22.0.1-internal-adhoc.conda.src; Deflater: Intel; Inflater: Intel; Provider GCS is not available; Picard version: 2.13.2-gridss
ERROR	2025-01-22 04:50:03	ReferenceCommandLineProgram	Reference genome used by gridss_preprocess/COLO829v003T.sv_prep.sorted.bam.gridss.working/tmp.COLO829v003T.sv_prep.sorted.bam.namedsorted.bam does not match reference genome GRCh38_full_analysis_set_plus_decoy_hla.fa. The reference supplied must match the reference used for every input.
[Wed Jan 22 04:50:03 GMT 2025] gridss.ComputeSamTags done. Elapsed time: 0.01 minutes.
Runtime.totalMemory()=505413632
Exception in thread "main" htsjdk.samtools.util.SequenceUtil$SequenceListsDifferException: In files /fusion/s3/umccr-temp-dev/temp_data/COLO829/oncoanalyser/2025012269ct0204_oob/scratch/1b/ea3398c051ad0235733d12d336192a/gridss_preprocess/COLO829v003T.sv_prep.sorted.bam.gridss.working/tmp.COLO829v003T.sv_prep.sorted.bam.namedsorted.bam and /fusion/s3/umccr-temp-dev/temp_data/COLO829/oncoanalyser/2025012269ct0204_oob/scratch/1b/ea3398c051ad0235733d12d336192a/GRCh38_full_analysis_set_plus_decoy_hla.fa
	at htsjdk.samtools.util.SequenceUtil.assertSequenceDictionariesEqual(SequenceUtil.java:345)
	at gridss.cmdline.ReferenceCommandLineProgram.ensureDictionaryMatches(ReferenceCommandLineProgram.java:134)
	at gridss.cmdline.ReferenceCommandLineProgram.ensureDictionaryMatches(ReferenceCommandLineProgram.java:120)
	at gridss.ComputeSamTags.doWork(ComputeSamTags.java:103)
	at picard.cmdline.CommandLineProgram.instanceMain(CommandLineProgram.java:305)
	at gridss.ComputeSamTags.main(ComputeSamTags.java:334)
Caused by: htsjdk.samtools.util.SequenceUtil$SequenceListsDifferException: Sequence dictionaries are not the same size (195, 3366)
	at htsjdk.samtools.util.SequenceUtil.assertSequenceListsEqual(SequenceUtil.java:251)
	at htsjdk.samtools.util.SequenceUtil.assertSequenceDictionariesEqual(SequenceUtil.java:334)
	at htsjdk.samtools.util.SequenceUtil.assertSequenceDictionariesEqual(SequenceUtil.java:320)
	at htsjdk.samtools.util.SequenceUtil.assertSequenceDictionariesEqual(SequenceUtil.java:343)
	... 5 more
```


retry with genome hmf

```bash
 bash run.sh  --portal_run_id "2025012269ct0204_oob" --tumor_wgs_library_id  "L2300007" --mode "wgs"   --subject_id "COLO829" --tumor_wgs_sample_id "COLO829v003"    --tumor_wgs_bam "s3://umccr-temp-dev/temp_data/COLO829v003/dragen/lignment-COLO829-hmf-GCA_000001405.15-ref/COLO829_tumor_dragen_somatic/COLO829_tumor_tumor.bam" --normal_wgs_sample_id "COLO829v003R"  --normal_wgs_library_id "L2300007"   --normal_wgs_bam "s3://umccr-temp-dev/temp_data/COLO829v003/dragen/lignment-COLO829-hmf-GCA_000001405.15-ref/COLO829_tumor_dragen_somatic/COLO829_normal_normal.bam"  --output_results_dir "s3://umccr-temp-dev/temp_data/COLO829/oncoanalyser/202501223zyveyph_oob/results/"   --output_staging_dir "s3://umccr-temp-dev/temp_data/COLO829/oncoanalyser/202501223zyveyph_oob/staging/"    --output_scratch_dir "s3://umccr-temp-dev/temp_data/COLO829/oncoanalyser/202501223zyveyph_oob/scratch/"
```
