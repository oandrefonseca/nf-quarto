#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

include {  QUARTO_RENDER_PAGEA     } from './modules/moduleA/main'
include {  QUARTO_RENDER_PAGEB     } from './modules/moduleB/main'
include {  QUARTO_RENDER_PAGEC     } from './modules/moduleC/main'
include {  QUARTO_RENDER_PROJECT   } from './modules/report/main'

first_script     = "${workflow.projectDir}/notebook/step_01.qmd"
second_script    = "${workflow.projectDir}/notebook/step_02.qmd"
third_script     = "${workflow.projectDir}/notebook/step_03.qmd"

workflow {

    //
    ch_page_config = Channel.fromPath(params.page_config, checkIfExists: true)
        .collect()

    // Passing notebooks for respective functions
    first  = QUARTO_RENDER_PAGEA(
        first_script,
        ch_page_config
    )

    second = QUARTO_RENDER_PAGEB(
        second_script,
        ch_page_config
    )

    // thrid  = QUARTO_RENDER_PAGEC(third_script)

    // Creates a single channel with all cache/freeze folders
    report_channels = first.mix(second)
        .collect()

    report_channels
        .view()

    report_template = Channel.fromPath("${workflow.projectDir}/assets/template/*")
    report_template = report_template
        .collect()

    QUARTO_RENDER_PROJECT(
        report_template,
        report_channels
    )

}
