#!/usr/bin/env nextflow

//params.in = "$baseDir/fastq/*.fastq.gz"
//params.out = "$HOME/test"

fastq_files = Channel.fromPath(params.in_files, type: 'file')

process fastqc {
    
    //publishDir params.out, mode: 'copy', overwrite: true

    //Note to self: specifying the file name literally coerces the input file into that name. It doesn't select files matching pattern of the literal.
    input:
    file fastq from fastq_files
 
    output:
    //file(fastq) into qc_files1
    //file("*_fastqc.{zip,html}") into qc_files1
    file fastq into fastq_files2
    file "*_fastqc.{zip,html}" into qc_files 
    """
    fastqc ${fastq}
    """
}

//qc_files1.collect().concat(fastq_files2.collect()).print()

process multiqc {

    publishDir params.out_loc, mode: 'copy', overwrite: true

    input:
    file(reports) from qc_files.collect().ifEmpty([])

    output:
    path "multiqc_report.html" into records

    """
    multiqc $reports
    """
}
