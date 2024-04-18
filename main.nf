#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

include { NFQUARTO_EXAMPLE } from './subworkflow/local/example.nf'

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Check mandatory parameters
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

// def checkPathParamList = [params.paramA, params.paramB, params.paramC]
// for (param in checkPathParamList) if (param) file(param, checkIfExists: true)

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    RUN ALL WORKFLOWS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

workflow {

    // Description
    ch_input       = Channel.fromPath(params.input, checkIfExists: true)

    // Description
    ch_template    = Channel.fromPath(params.template, checkIfExists: true)
    ch_page_config = Channel.fromPath(params.page_config, checkIfExists: true)
        .collect()

    NFQUARTO_EXAMPLE(
        ch_input
    )

}

workflow.onComplete {
    log.info(
        workflow.success ? "\nDone! Open the following report in your browser -> ${launchDir}/${params.project_name}/report/index.html\n" :
        "Oops... Something went wrong"
    )
}
