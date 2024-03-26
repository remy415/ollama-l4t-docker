# Ollama Tegra Fix
## Jetson support should be included as of Ollama 0.1.30. Please see the official repo for more information https://github.com/ollama/ollama

### ENSURE THESE TWO VARIABLES ARE SET:
`export LD_LIBRARY_PATH="/usr/local/cuda/lib64:/usr/local/cuda/compat:/usr/local/cuda/include"`
`export OLLAMA_SKIP_CPU_GENERATE="1"`

## Also, Tegra devices will fail `go generate ./...` unless architectures are set:
### L4T_VERSION.major >= 36:    # JetPack 6
`export CMAKE_CUDA_ARCHITECTURES="87"`
### L4T_VERSION.major >= 34:  # JetPack 5
`export CMAKE_CUDA_ARCHITECTURES="72;87"`
### L4T_VERSION.major == 32:  # JetPack 4
`export CMAKE_CUDA_ARCHITECTURES="53;62;72"`
