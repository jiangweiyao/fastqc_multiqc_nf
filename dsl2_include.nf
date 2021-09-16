#!/usr/bin/env nextflow

nextflow.enable.dsl=2

include { fastqc_multiqc_pipeline } from './fastqc_multiqc_dsl2.nf'

fastq_file = Channel.fromPath(params.in, type: 'file')

workflow {
    fastq_file = Channel.fromPath(params.in, type: 'file')
    fastqc_multiqc_pipeline(fastq_file)
}
