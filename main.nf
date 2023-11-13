#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// report_template  = "${workflow.projectDir}/assets/template"
first_script     = "${workflow.projectDir}/notebook/step_01.qmd"
second_script    = "${workflow.projectDir}/notebook/step_02.qmd"
third_script     = "${workflow.projectDir}/notebook/step_03.qmd"

process SCBTC_TEMPLATE {

    publishDir "${params.outdir}", mode: 'copy'

    input:
        val(report_template)

    output:
        path("${project_name}"), emit: project_folder

    shell:
        """
        quarto render --to html
        """
}

process SCBTC_ONE {

    publishDir "${params.outdir}/report", mode: 'copy'
    stageInMode 'copy'

    input:
        path(first_script)

    output:
        tuple path(first_script), path("_freeze/step_01")

    shell:
        """
        quarto create-project --type website
        quarto render -P project_name:First
        """

}

process SCBTC_TWO {

    publishDir "${params.outdir}", mode: 'copy'

    input:
        path(second_script)

    output:
        path("basic")

    shell:
        """
        mkdir -p basic && cp -L ${second_script} basic/${second_script}

        quarto create-project --type website
        quarto render basic/${second_script} -P project_name:Test

        """
}

process SCBTC_THREE {

    publishDir "${params.outdir}/report", mode: 'copy'
    stageInMode 'copy'

    input:
        path(third_script)

    output:
        tuple path(third_script), path("_freeze/step_03")

    shell:
        """
        quarto create-project --type website
        quarto render -P project_name:Three
        """

}

process SCBTC_RENDER {

    debug true
    publishDir "${params.outdir}/report", mode: 'copy'
    stageInMode 'copy'

    input:
        path(report_template)
        path(report_channels)

    output:
        path("*"), emit: project_folder

    shell:
        """
        quarto render --use-freezer --cache
        """
}

workflow {

    first  = SCBTC_ONE(first_script)
    // second = SCBTC_TWO(second_script)
    thrid  = SCBTC_THREE(third_script)

    // // Mixing
    report_channels = first.mix(thrid)
        .collect()

    report_channels
        .view()

    report_template = Channel.fromPath("${workflow.projectDir}/assets/template/*")
    report_template = report_template
        .collect()

    SCBTC_RENDER(
        report_template,
        report_channels
    )

}
