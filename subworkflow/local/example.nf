#!/usr/bin/env nextflow

include {  QUARTO_RENDER_PAGEA     } from '../../modules/local/moduleA/main.nf'
include {  QUARTO_RENDER_PAGEB     } from '../../modules/local/moduleB/main.nf'
include {  QUARTO_RENDER_PAGEC     } from '../../modules/local/moduleC/main.nf'
include {  QUARTO_RENDER_PROJECT   } from '../../modules/local/report/main.nf'

workflow NFQUARTO_EXAMPLE {

    take:
        ch_input          // channel: []

    main:

        // Importing notebook
        ch_notebookA   = Channel.fromPath(params.notebookA, checkIfExists: true)
        ch_notebookB   = Channel.fromPath(params.notebookB, checkIfExists: true)
        ch_notebookC   = Channel.fromPath(params.notebookC, checkIfExists: true)

        ch_template    = Channel.fromPath(params.template, checkIfExists: true)
        ch_page_config = Channel.fromPath(params.page_config, checkIfExists: true)
            .collect()

        // Version channel
        ch_versions = Channel.empty()

        // Passing notebooks for respective functions
        first = QUARTO_RENDER_PAGEA(
            ch_input,
            ch_notebookA,
            ch_page_config,
            params.project_name,
            params.paramA // Question 1: Is this the best way to map parameters to process?
        )

        second = QUARTO_RENDER_PAGEB(
            ch_input,
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
                    ch_input,
                    ch_notebookC,
                    ch_page_config,
                    params.project_name,
                    params.paramC
                )
            ]

        // Gathering all notebooks
        ch_qmd = ch_notebookA.mix(ch_notebookB, ch_notebookC)
            .collect()

        ch_qmd = ch_notebookA.mix(ch_notebookB)
            .collect()

        // Creates a single channel with all cache/freeze folders
        ch_cache = first.mix(second, third)
            .collect()

        ch_cache = first.mix(second)
            .collect()

        // Load Nf-Quarto template
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
    emit:
        versions     = ch_versions

}
