process QUARTO_RENDER_PAGEA {

    tag "Performing analysis moduleA"

    input:
        path(config)

        val(project_name)
        val(paramA)

    output:
        path("_freeze/moduleA"),   emit: cache

    when:
        task.ext.when == null || task.ext.when

    script:
        def project_name = project_name ? "-P project_name:${project_name}" : ""
        def paramA       = paramA       ? "-P paramA:${paramA}" : ""
        """
            cat moduleA.qmd > out
        """
    stub:
        """
        quarto render moduleA.qmd ${project_name} ${paramA}
        """

}
