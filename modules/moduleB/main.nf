process QUARTO_RENDER_PAGEB {

    tag "Performing analysis ${notebook.baseName}"

    input:
        path(notebook)
        path(config)

    output:
        path("_freeze/${notebook.baseName}"),   emit: cache

    when:
        task.ext.when == null || task.ext.when

    script:
        """
        quarto render ${notebook}
        """
    stub:
        """
        """

}

