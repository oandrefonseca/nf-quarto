# Use a specific version of Ubuntu as the base image
FROM --platform=linux/x86_64 rocker/verse:latest

# Timezone settings
ENV TZ=US/Central
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && apt-get install -y \
    software-properties-common \
    dirmngr \
    gnupg \
    apt-transport-https \
    ca-certificates \
    wget \
    libcurl4-gnutls-dev \
    libssl-dev \
    libxml2-dev

# Install Python3
RUN apt-get install -y \
    python3 \
    python3-pip

# Install Python packages for data science
RUN python3 -m pip install --no-cache-dir numpy pandas scikit-learn matplotlib seaborn jupyter
RUN python3 -m pip install --no-cache-dir jupyter-cache
RUN python3 -m pip install --no-cache-dir papermill

# Set the working directory
WORKDIR /data

# Command to run on container start
CMD ["bash"]
