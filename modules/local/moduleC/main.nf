process QUARTO_RENDER_PAGEC {

    tag "Performing analysis moduleC"

    input:
        path(config)

        val(project_name)
        val(paramC)

    output:
        path("_freeze/moduleC"),   emit: cache

    when:
        task.ext.when == null || task.ext.when

    script:
        def project_name = project_name ? "-P project_name:${project_name}" : ""
        def paramC       = paramC       ? "-P paramC:${paramC}" : ""
        """
        quarto render moduleC.qmd ${project_name} ${paramC}
        """
    stub:
        """
        """

}

