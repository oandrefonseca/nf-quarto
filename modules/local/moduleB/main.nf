process QUARTO_RENDER_PAGEB {

    tag "Performing analysis moduleB"

    input:
        path(input)
        path(notebook)
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
        quarto render ${notebook} ${project_name} ${paramB}
        """
    stub:
        """
        """

}
