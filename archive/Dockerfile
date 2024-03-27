ARG GOLANG_VERSION=1.21.3
ARG CMAKE_VERSION=3.22.1
ARG L4T_VERSION=r35.4.1
ARG JETSON_JETPACK="5.1.2"

FROM ollama/ollama:0.1.30-rc4 as ollama-base

# Runtime stages
FROM dustynv/llama_cpp:gguf-${L4T_VERSION} as runtime-arm64
ARG JETSON_JETPACK
COPY ./scripts/tegra_linux_deps.sh /opt/
RUN apt-get update && apt-get install -y ca-certificates && CMAKE_VERSION=${CMAKE_VERSION} GOLANG_VERSION=${GOLANG_VERSION} sh /opt/tegra_linux_deps.sh
COPY --from=ollama-base /bin/ollama /bin/ollama
EXPOSE 11434
ENV OLLAMA_HOST 0.0.0.0
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV LD_LIBRARY_PATH=/usr/local/cuda/lib:/usr/local/cuda/lib64:/usr/local/cuda/include
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility
ENV JETSON_JETPACK=${JETSON_JETPACK}

ENTRYPOINT ["/bin/ollama"]
CMD ["serve"]
