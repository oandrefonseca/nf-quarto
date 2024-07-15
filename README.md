<!-- badges: start -->

[![DOI](https://zenodo.org/badge/718295582.svg)](https://zenodo.org/doi/10.5281/zenodo.12746772)

<!-- badges: end -->

# nf-quarto <img src="assets/template/logotype.png" align="right" height="138" />

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

### Running the Pipeline with Standard Settings

```bash
nextflow run main.nf -resume
```

### Skipping Modules

Avoid rendering specific modules by adjusting the run command as shown below:

```bash
nextflow run main.nf --skip_python true -resume
```

## Leveraging and Customizing the Template for Your Project

If you want to use this template for your project without linking back to the original repository, you can clone it and then sever the link to the original remote:

1. **Clone the Repository**:
   Clone `nf-quarto` to your local machine:

```bash
git clone https://github.com/yourusername/nf-quarto.git
cd nf-quarto
```

2. **Remove the Original Remote**:
   Remove the original `origin` to disconnect from the source repository:

```bash
git remote remove origin
```

3. **Set Up a New Remote (Optional)**:
   If you have a new repository where you want to push changes, add it as the new `origin`:

 ```bash
 git remote add origin https://github.com/yourusername/new-repo-name.git
 git push -u origin master  # Replace 'master' with your branch if different
 ```

### Assets and Styling

The `assets` folder is essential for the visual presentation of the Quarto reports. It contains all necessary stylesheets and resources for the Quarto website rendering. 

### Logo Customization

Included in the `assets` folder is the `logotype.png`. This default logo is meant to be replaced with your own to personalize the reports. Simply prepare your custom logo in PNG format, rename it to `logotype.png`, and replace the existing file in the `assets` folder to reflect your project's identity.

## Configuration and Automation

### GitHub Actions

The repository is configured to use GitHub Actions to automatically build and publish the Docker image whenever changes are pushed to the `main` branch or when new tags that match the pattern `v*.*.*` are created. The action specifically tracks changes to the Dockerfile and the action's workflow file:

- **Dockerfile Path**: `docker/nf-quarto.Dockerfile`
- **Workflow File Path**: `.github/workflows/docker-basic-publish.yml`

To ensure the GitHub Actions workflow can push the Docker image to Docker Hub, you need to set up the following secrets in your repository:

1. **DOCKERHUB_USERNAME**: Your Docker Hub username.
2. **DOCKERHUB_PASSWORD**: Your Docker Hub password or access token.

For instructions on how to set up repository secrets, refer to the [official GitHub documentation](https://docs.github.com/en/actions/security-guides/encrypted-secrets).

### Docker Configuration

Our Docker configuration is stored within the `Docker` directory of the repository. The Dockerfile `nf-quarto.Dockerfile` is located at `docker/nf-quarto.Dockerfile`.

## Citation

If you utilize this repository in your research, please consider citing it. Your support helps us to continue improving our work and assisting the scientific community. Registered on Zenodo: 

[![DOI](https://zenodo.org/badge/718295582.svg)](https://zenodo.org/doi/10.5281/zenodo.12746772)

## License

This project is available under the GNU General Public License v3.0. See the [LICENSE](./LICENSE) file for more details.
