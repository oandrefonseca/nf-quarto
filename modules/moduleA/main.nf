process QUARTO_RENDER_PAGEA {

    input:
        path(notebook)
        path(config)

    output:
        tuple path(notebook), path("_freeze/${notebook.baseName}")

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

