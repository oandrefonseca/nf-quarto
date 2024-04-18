# nf-quarto

This a template that integrates Nextflow pipeline with Quarto notebooks. Here are some features available:

- [X] The pipeline has skip statements inspired by the Sarek pipeline
- [X] Successfully aligns Nextflow (-resume) and Quarto caching (_freeze)
- [X] Dynamically renders vignette-like websites
- [X] It handles parameters on the Quarto command-line
- [X] Also, it supports both Python and R notebooks!

---

### 1. Building docker image

```{bash}

docker build -t nf-quarto -f Dockerfile .

```

### 2. Running with basic settings

```{bash}

nextflow run main.nf -resume

```

### 3. Avoid rendering specific modules

```{bash}

nextflow run main.nf --skip_python true -resume

```

