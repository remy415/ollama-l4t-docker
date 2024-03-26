# Ollama Dockerfile for Jetson

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
