#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

include {  QUARTO_RENDER_PAGEA     } from './modules/moduleA/main'
include {  QUARTO_RENDER_PAGEB     } from './modules/moduleB/main'
include {  QUARTO_RENDER_PAGEC     } from './modules/moduleC/main'
include {  QUARTO_RENDER_PROJECT   } from './modules/report/main'

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Check mandatory parameters
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

// def checkPathParamList = [params.paramA, params.paramB, params.paramC]
// for (param in checkPathParamList) if (param) file(param, checkIfExists: true)

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    RUN MAIN WORKFLOW
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

workflow {

    // Importing notebook
    ch_notebookA   = Channel.fromPath(params.notebookA, checkIfExists: true)
    ch_notebookB   = Channel.fromPath(params.notebookB, checkIfExists: true)
    ch_notebookC   = Channel.fromPath(params.notebookC, checkIfExists: true)

    ch_template    = Channel.fromPath(params.template, checkIfExists: true)
    ch_page_config = Channel.fromPath(params.page_config, checkIfExists: true)
        .collect()

    // Passing notebooks for respective functions
    first = QUARTO_RENDER_PAGEA(
        ch_notebookA,
        ch_page_config,
        params.project_name,
        params.paramA
    )

    second = QUARTO_RENDER_PAGEB(
        ch_notebookB,
        ch_page_config,
        params.project_name,
        params.paramB
    )

    // Adding conditions for skipping notebooks/analysis
    (ch_notebookC, third) = params.skip_python
        ? [Channel.empty(), Channel.empty()]
        : [
            ch_notebookC,
            QUARTO_RENDER_PAGEC(
                ch_notebookC,
                ch_page_config,
                params.project_name,
                params.paramC
            )
        ]

    // Gathering all notebooks
    ch_qmd = ch_notebookA.mix(ch_notebookB, ch_notebookC)
        .collect()

    // Creates a single channel with all cache/freeze folders
    ch_cache = first.mix(second, third)
        .collect()

    // Load SCRATCH/BTC template
    ch_template = ch_template
        .collect()

    // Inspecting channels content
    ch_cache.view()
    ch_page_config.view()
    ch_qmd.view()

    // Gathering intermediate pages and rendering the project
    QUARTO_RENDER_PROJECT(
        ch_template,
        ch_qmd,
        ch_cache
    )

}
