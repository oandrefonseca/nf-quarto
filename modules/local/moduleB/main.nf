process QUARTO_RENDER_PAGEB {

    tag "Performing analysis moduleB"

    input:
        path(config)

        val(project_name)
        val(paramB)

    output:
        path("_freeze/moduleB"),   emit: cache

    when:
        task.ext.when == null || task.ext.when

    script:
        def project_name = project_name ? "-P project_name:${project_name}" : ""
        def paramB       = paramB       ? "-P paramB:${paramB}" : ""
        """
        cat moduleB.qmd > out
        """
    stub:
        """
        quarto render moduleB.qmd ${project_name} ${paramB}
        """

}
