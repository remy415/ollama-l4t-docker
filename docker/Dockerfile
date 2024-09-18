ARG GOLANG_VERSION=1.21.3
ARG CMAKE_VERSION=3.22.1
ARG L4T_VERSION=r36.2.0
ARG OLLAMA_REPOSITORY="ollama"
ARG OLLAMA_BRANCH="main"
ARG JETSON_JETPACK="6.0.0"

# Copy the minimal context we need to run the generate scripts
FROM dustynv/llama_cpp:${L4T_VERSION} AS ollama-cuda-l4t-base
ARG CMAKE_VERSION
ARG GOLANG_VERSION
ARG OLLAMA_REPOSITORY
ARG JETSON_JETPACK
WORKDIR /go/src/github.com/jmorganca/
COPY ./scripts/tegra_linux_deps.sh /opt/
RUN apt-get update && apt-get install -y ca-certificates && CMAKE_VERSION=${CMAKE_VERSION} GOLANG_VERSION=${GOLANG_VERSION} sh /opt/tegra_linux_deps.sh
ENV PATH /usr/local/bin:/usr/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH=/usr/local/cuda/lib:/usr/local/cuda/lib64/:/usr/local/cuda/include:/usr/lib/aarch64-linux-gnu
ENV OLLAMA_SKIP_CPU_GENERATE="1"
ENV CGO_ENABLED="1"
ENV CMAKE_CUDA_ARCHITECTURES="87"
ENV JETSON_JETPACK=${JETSON_JETPACK}
ADD https://api.github.com/repos/${OLLAMA_REPOSITORY}/ollama/git/refs/heads/${OLLAMA_BRANCH} version.json
RUN git clone --depth=1 --recursive https://github.com/${OLLAMA_REPOSITORY}/ollama.git
WORKDIR /go/src/github.com/jmorganca/ollama
RUN go generate ./...
RUN go build .

# Runtime stages
FROM dustynv/llama_cpp:${L4T_VERSION} as runtime-arm64
ARG JETSON_JETPACK
COPY ./scripts/tegra_linux_deps.sh /opt/
RUN apt-get update && apt-get install -y ca-certificates && CMAKE_VERSION=${CMAKE_VERSION} GOLANG_VERSION=${GOLANG_VERSION} sh /opt/tegra_linux_deps.sh
COPY --from=ollama-cuda-l4t-base /go/src/github.com/jmorganca/ollama/ollama /bin/ollama
EXPOSE 11434
ENV OLLAMA_HOST 0.0.0.0
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV LD_LIBRARY_PATH=/usr/local/cuda/lib:/usr/local/cuda/lib64:/usr/local/cuda/include:/usr/lib/aarch64-linux-gnu/libcuda.so
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility
ENV JETSON_JETPACK=${JETSON_JETPACK}

ENTRYPOINT ["/bin/ollama"]
CMD ["serve"]
