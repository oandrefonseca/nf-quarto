process QUARTO_RENDER_PAGEA {

    tag "Performing analysis ${notebook.baseName}"

    input:
        path(notebook)
        path(config)

        val(project_name)
        val(paramA)

    output:
        path("_freeze/${notebook.baseName}"),   emit: cache

    when:
        task.ext.when == null || task.ext.when

    script:
        def project_name = project_name ? "-P project_name:${project_name}" : ""
        def paramA       = paramA       ? "-P paramA:${paramA}" : ""
        """
        quarto render ${notebook} ${project_name} ${paramA}
        """
    stub:
        """
        """

}
