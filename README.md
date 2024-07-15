# nf-quarto

![DOI](https://zenodo.org/badge/718295582.svg)](https://zenodo.org/doi/10.5281/zenodo.12746772)

Welcome to `nf-quarto`, a robust and dynamic template that seamlessly integrates Nextflow pipelines with Quarto notebooks. Designed to enhance reproducibility and ease of use, this template is ideal for researchers and developers seeking to combine the power of workflow automation with the elegance of literate programming.

## Key Features

- **Smart Skipping**: Incorporates conditional execution logic inspired by the Sarek pipeline to efficiently manage workflow components.
- **Enhanced Session Management**: Achieves seamless integration of Nextflow's `-resume` capability with Quarto's `_freeze` caching mechanism, preserving computational resources and time.
- **Dynamic Web Rendering**: Automatically generates interactive, vignette-like websites that present your analysis with clarity and interactivity.
- **Flexible Parameter Handling**: Manages parameters directly through the Quarto command line, providing a streamlined user experience.
- **Cross-Language Support**: Offers full support for both Python and R notebooks, accommodating a wide range of scientific computing needs.

## Quick Start Guide

### Building the Docker Image

```bash
docker build -t nf-quarto -f Dockerfile .
```

### Running the Pipeline with Basic Settings

```bash
nextflow run main.nf -resume
```

### Customizing Execution

Avoid rendering specific modules by adjusting the run command as shown below:

```bash
nextflow run main.nf --skip_python true -resume
```

## Settings

Detailed configuration settings can be tailored to fit your specific requirements. Explore the repository's documentation to adjust pipeline parameters, manage dependencies, and more.

## Citation

If you utilize this repository in your research, please consider citing it. Your support helps us to continue improving our work and assisting the scientific community. Registered on Zenodo:

[![DOI](https://zenodo.org/badge/718295582.svg)](https://zenodo.org/doi/10.5281/zenodo.12746772)

## License

This project is available under the GNU General Public License v3.0. See the [LICENSE](./LICENSE) file for more details.

---

This revised README adds more structure, utilizes markdown more effectively for better visual appeal, and includes sections that can be further expanded based on additional details you might want to include about configuration settings or other advanced usage.