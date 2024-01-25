#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

include {  QUARTO_RENDER_PAGEA     } from './modules/moduleA/main'
include {  QUARTO_RENDER_PAGEB     } from './modules/moduleB/main'
include {  QUARTO_RENDER_PAGEC     } from './modules/moduleC/main'
include {  QUARTO_RENDER_PROJECT   } from './modules/report/main'

workflow {

    // Importing notebook
    ch_notebookA   = Channel.fromPath(params.notebookA, checkIfExists: true)
    ch_notebookB   = Channel.fromPath(params.notebookB, checkIfExists: true)
    // ch_notebookC   = Channel.fromPath(params.notebookC, checkIfExists: true)

    ch_template    = Channel.fromPath(params.template, checkIfExists: true)
    ch_page_config = Channel.fromPath(params.page_config, checkIfExists: true)
        .collect()

    // Passing notebooks for respective functions
    first  = QUARTO_RENDER_PAGEA(
        ch_notebookA,
        ch_page_config
    )

    second = QUARTO_RENDER_PAGEB(
        ch_notebookB,
        ch_page_config
    )

    // thrid  = QUARTO_RENDER_PAGEC(third_script)

    // All notebooks
    ch_qmd = ch_notebookA.mix(ch_notebookB)
        .collect()

    // Creates a single channel with all cache/freeze folders
    ch_cache = first.mix(second)
        .collect()

    ch_template = ch_template
        .collect()

    //
    ch_cache.view()
    ch_page_config.view()
    ch_qmd.view()

    QUARTO_RENDER_PROJECT(
        ch_page_config,
        ch_qmd,
        ch_cache
    )

}
