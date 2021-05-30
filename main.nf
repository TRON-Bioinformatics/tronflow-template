#!/usr/bin/env nextflow

params.help= false
params.input_files = false
params.output = 'output'
params.memory = "3g"
params.cpus = 1

if (params.help) {
    log.info params.help_message
    exit 0
}

// checks required inputs
if (params.input_files) {
  Channel
    .fromPath(params.input_files)
    .splitCsv(header: ['name', 'bam'], sep: "\t")
    .map{ row-> tuple(row.name, file(row.bam)) }
    .set { input_files }
} else {
    log.error "--input_files is required"
    exit 1
}

input_files.into { input_files_for_fastq; input_files_for_fasta }

process bam2fastq {
    cpus params.cpus
    memory params.memory
    tag "${name}"
    publishDir "${params.output}/${name}", mode: "copy"

    input:
    	set name, file(bam) from input_files_for_fastq

    output:
	    set val("${name}"), file("${bam.baseName}.1.fastq"), file("${bam.baseName}.2.fastq") into fastqs

    """
    samtools fastq -1 ${bam.baseName}.1.fastq -2 ${bam.baseName}.2.fastq ${bam}
	"""
}

process bam2fasta {
    cpus params.cpus
    memory params.memory
    tag "${name}"
    publishDir "${params.output}/${name}", mode: "copy"

    input:
    	set name, file(bam) from input_files_for_fasta

    output:
	    set val("${name}"), file("${bam.baseName}.1.fasta"), file("${bam.baseName}.2.fasta") into fastas

    """
    samtools fasta -1 ${bam.baseName}.1.fasta -2 ${bam.baseName}.2.fasta ${bam}
	"""
}

fastqs.join(fastas).map {it.join("\t")}.collectFile(name: "${params.output}/output_files.txt", newLine: true)
