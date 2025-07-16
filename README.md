# Command Line Toolbox

A Docker image containing useful command-line tools for development environments.

## Features

- Ubuntu-based environment with common development tools
- Zsh shell with Oh My Zsh (avit theme)
- Pre-installed utilities: git, curl, wget, jq, yq, Python 3, tmux, vim, swaks
- Configurable username via build arguments

## Getting Started

### Prerequisites

- Docker or Podman
- Access to a container registry (optional for pushing)

### Building the Image

1. Clone this repository:
   ```
   git clone <repository-url>
   cd command-line-toolbox
   ```

2. Configure your environment:
   ```
   cp .env_template .env
   # Edit .env with your registry details
   ```

3. Build and push the image:
   ```
   ./_run/build_and_push.sh
   ```

## Using the Image

Run the container with:

```
docker run -it registry.example.com/command-line-toolbox:latest zsh
```

## Helm Chart

This repository includes Helm chart packaging and publishing:

1. Package the chart:
   ```
   ./_run/helm_package.sh
   ```

2. Publish the chart:
   ```
   ./_run/helm_publish.sh
   ```

## Environment Variables

| Variable | Description |
|----------|-------------|
| DOCKER_REGISTRY | Your Docker registry URL |
| IMAGE_NAME | Name for the Docker image |
| TAG | Version tag for the image |
| NEXUS_USERNAME | Username for registry authentication |
| NEXUS_PASSWORD | Password for registry authentication |
