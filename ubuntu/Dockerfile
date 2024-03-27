ARG GOLANG_VERSION=1.22.1
ARG CMAKE_VERSION=3.22.1
ARG L4T_VERSION=r35.4.1
ARG JETSON_JETPACK="5.1.2"

FROM nvidia/cuda:11.3.1-devel-ubuntu20.04 as cuda-arm64-build
ARG GOLANG_VERSION
ARG CMAKE_VERSION

WORKDIR /

COPY ./scripts/ubuntu_linux_deps.sh /ubuntu_linux_deps.sh
RUN CMAKE_VERSION=${CMAKE_VERSION} GOLANG_VERSION=${GOLANG_VERSION} sh /ubuntu_linux_deps.sh

COPY ollama /go/src/github.com/jmorgana/ollama

WORKDIR /go/src/github.com/jmorgana/ollama/llm/generate

RUN OLLAMA_SKIP_CPU_GENERATE=1 bash gen_linux.sh

RUN mkdir -p /go/src/github.com/jmorganca/ollama/dist/deps/

WORKDIR /go/src/github.com/jmorgana/ollama

RUN go build -trimpath .

FROM dustynv/build-essential:r35.4.1
COPY --from=cuda-arm64-build /go/src/github.com/jmorgana/ollama/ollama /bin/ollama

EXPOSE 11434
ENV OLLAMA_HOST 0.0.0.0
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV LD_LIBRARY_PATH=/usr/local/cuda/lib:/usr/local/cuda/lib64:/usr/local/cuda/include
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility
ENV JETSON_JETPACK=${JETSON_JETPACK}

ENTRYPOINT ["/bin/ollama"]

CMD ["serve"]
