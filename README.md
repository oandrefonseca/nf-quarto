# nf-quarto

[![DOI](https://zenodo.org/badge/718295582.svg)](https://zenodo.org/doi/10.5281/zenodo.12746772)

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

## Configuration and Automation

### GitHub Actions

The repository is configured to use GitHub Actions to automatically build and publish the Docker image whenever changes are pushed to the `main` branch or when new tags that match the pattern `v*.*.*` are created. The action specifically tracks changes to the Dockerfile and the action's workflow file:

- **Dockerfile Path**: `docker/nf-quarto.Dockerfile`
- **Workflow File Path**: `.github/workflows/docker-basic-publish.yml`

#### Steps to Set Up Secrets:

To ensure the GitHub Actions workflow can push the Docker image to Docker Hub, you need to set up the following secrets in your repository:

1. **DOCKERHUB_USERNAME**: Your Docker Hub username.
2. **DOCKERHUB_PASSWORD**: Your Docker Hub password or access token.

For instructions on how to set up repository secrets, refer to the official GitHub documentation.

### Docker Configuration

Our Docker configuration is stored within the Docker directory of the repository. The Dockerfile nf-quarto.Dockerfile is located at docker/nf-quarto.Dockerfile.

## Citation

If you utilize this repository in your research, please consider citing it. Your support helps us to continue improving our work and assisting the scientific community. Registered on Zenodo:

[![DOI](https://zenodo.org/badge/718295582.svg)](https://zenodo.org/doi/10.5281/zenodo.12746772)

## License

This project is available under the GNU General Public License v3.0. See the [LICENSE](./LICENSE) file for more details.
