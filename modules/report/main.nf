process QUARTO_RENDER_PROJECT {

    tag "Creating final report"
    publishDir "${params.outdir}/${params.project_name}", mode: 'copy'

    input:
        path(template)
        path(qmd)
        path(cache), stageAs: '_freeze/*'

    output:
        path("report"), emit: project_folder

    shell:
        """
        quarto render .
        """
}
