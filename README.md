# (DEPRECATED) Ollama Dockerfile for Jetson
Note: This repo is deprecated. Please visit [here](https://github.com/dusty-nv/jetson-containers/tree/master/packages/llm/ollama) for an updated container build process for Jetson containers. This repository does not work with latest r36.3.0 Jetson release.

This Dockerfile was designed to be used with L4T 35.4.1 (Jetpack 5). If you want to use it on the new Jetpack 6, 
make sure you pass the build argument.

* --build-arg L4T_VERSION=<version> where <version> corresponds to a valid l4t base container hosted by [dusty-nv](https://github.com/dusty-nv/jetson-containers).
Ensure you find a container version matching the version of L4T you are running, Jetpack 6 = r36.x.x

`docker build -t l4t_ollama_new:0.1.0 --build-arg L4T_VERSION=r36.2.0 .`

## Usage

1. Clone the repository
   
```
git clone https://github.com/remy415/ollama-l4t-docker.git
cd ollama-l4t-docker/docker
```

2. Build the Docker image

* docker build -t <your_image_name:tag> . e.g.

```
docker build -t l4t_ollama_new:0.1.0 .
```

3. Run the Docker image

* docker run -d --gpus=all -v ollama:/root/.ollama -p 11434:11434 --name <your_container_name> <your_image_name:tag> e.g.

```
docker run -d --gpus=all -v ollama:/root/.ollama -p 11434:11434 --name ollama l4t_ollama_new:0.1.0
```

4. Connect to the API

Note: this assumes you have Ollama installed outside of Docker.

* ollama run <desired_model> e.g. 

```ollama run mistral```

