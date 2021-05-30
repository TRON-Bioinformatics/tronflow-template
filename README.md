# TronFlow Template

This repository holds a dummy Nextflow workflow aiming to serve as a template to develop new workflows.

## Content structure

Apart from writing the actual Nextflow workflow there are a number of resources that are needed in 
order to ensure reproducibility best practices and to make the development process as easy as possible.

```
tronflow-template
├── .gitignore
├── .gitlab-ci.yml
├── environment.yml
├── LICENSE
├── main.nf
├── Makefile
├── nextflow.config
├── README.md
├── test_data
│   ├── input_data.txt
│   ├── TESTX_S1_L001.bam
│   ├── TESTX_S1_L001.bam.bai
│   ├── TESTX_S1_L002.bam
│   ├── TESTX_S1_L002.bam.bai
```

### .gitignore

This file lists files and folders that are to be ignored by git.

### .gitlab-ci.yml

This file contains the definition of a Docker image and how to run tests in the GitLab continuous integration environment.
The Docker image contains all necessary resources to run a Nextflow workflow with a Conda environment.
The test script will be executed in the GitLab continuous integration environment every time new commits are pushed to any branch in GitLab.
The tests are implemented with make, see `Makefile` below.

### environment.yml

The conda environment for the Nextflow workflow is defined in this file. 
Bear in mind that most of bioinformatics software will be available through `bioconda` repository.

### LICENSE

The software license. By default we are using MIT license for TronFlow workflows, although this is decided on a workflow basis.

### main.nf

The Nextflow workflow definition. 
In order to be able to run the workflow by pointing to the GitHub repository this file needs to be named `main.nf`.

### Makefile

This file contains the definition for the `make` tool. This is convenient to define which tests need to be executed in the CI environment.

### nextflow.config

This file contains some Nextflow configuration like:
- Workflow metadata
- Workflow version
- Predefined conda and test profiles

### README.md

This readme

### test_data

A folder with test data. Having a minimal dataset to run tests is fundamental to minimise the feedback loop during development. 
In other words, run quick tests and detect errors fast. 
We provide in this folder several test datasets that can be used in different TronFlow workflows.

Among them:
- `TESTX_S1_L001/2_R1/2_001.fastq.gz`. FASTQ files on the minimal reference genome region.
- `TESTX_S1_L001.bam` and `TESTX_S1_L002.bam`. Downsampled BAM files on the minimal reference genome region.
- `test_single_sample.vcf` and `test_tumor_normal.vcf`. VCF files with a diverse set of mutations in the minimal reference genome region for a single sample and a tumor-normal pair.
- `ucsc.hg19.minimal.fasta`. Minimal reference genome with the first 1,000,000 bp of the first 4 chromosomes of the human genome hg19. This includes several indexes for different purposes.
- `dbsnp_138.hg19.minimal.vcf`. dbSNP VCF on the minimal reference genome region.
- `gnomad.minimal.vcf.gz`. GnomAD VCF on the minimal reference genome region.
- `1000G_phase1.indels.hg19.sites.minimal.vcf` and `Mills_and_1000G_gold_standard.indels.hg19.sites.sorted.minimal.vcf`. Known indels resources on the minimal reference genome region.
- `minimal_intervals.bed` and `minimal_intervals.intervals`. Minimal reference genome region in BED and intervals format.

## Requirements

- Nextflow >=19.10.0
- Java >= 8
- Conda >=4.9

## How to run it

```
$ nextflow run tron-bioinformatics/tronflow-template -profile conda --help

Usage:
    nextflow run tron-bioinformatics/tronflow-template -profile conda --input_files input_files

Input:
    * input_files: the path to a tab-separated values file containing in each row the sample name and a BAM file
    The input file does not have header!
    Example input file:
    name1	bam1
    name2	bam2

Optional input:
    * output: the folder where to publish output
    * memory: the ammount of memory used by each job (default: 16g)
    * cpus: the number of CPUs used by each job (default: 2)

Output:
    * Output FASTQ and FASTA out of BAM files
```

## How to run tests

Run:
`make`


## References

- Di Tommaso, P., Chatzou, M., Floden, E. W., Barja, P. P., Palumbo, E., & Notredame, C. (2017). Nextflow enables reproducible computational workflows. Nature Biotechnology, 35(4), 316–319. https://doi.org/10.1038/nbt.3820
