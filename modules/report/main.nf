process QUARTO_RENDER_PROJECT {

    input:
        path(report_template)
        path(report_channels)

    output:
        path("report"), emit: project_folder

    shell:
        """
        quarto render --use-freezer --cache
        """
}
