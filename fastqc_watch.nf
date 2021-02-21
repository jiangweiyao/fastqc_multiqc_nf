#!/usr/bin/env nextflow

//params.in = "$baseDir/fastq/*.fastq.gz"
//params.out = "$HOME/test"

fastq_files = Channel.watchPath(params.in_files, type: 'file')

process fastqc {
    
    cpus 1 
    memory '2 GB'   
    publishDir params.out, mode: 'copy', overwrite: true, pattern: '*.{html}'

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


