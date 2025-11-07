FROM ubuntu:24.04

# Install dependencies for build and runtime
RUN apt-get update && apt-get install -y \
    build-essential cmake git wget curl libcurl4-openssl-dev libcurl4 && \
    rm -rf /var/lib/apt/lists/*

# Clone llama.cpp repository
WORKDIR /app
RUN git clone https://github.com/ggerganov/llama.cpp.git .

# Build CPU ONLY llama-server
RUN cmake -B build -DLLAMA_CURL=ON -DGGML_CUDA=OFF -DLLAMA_VULKAN=OFF -DLLAMA_CUBLAS=OFF
RUN cmake --build build --config Release -j $(nproc)

# Copy binary to /usr/local/bin
RUN cp build/bin/llama-server /usr/local/bin/llama-server
RUN cp build/bin/llama-cli /usr/local/bin/llama-cli

COPY entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Expose REST API port
EXPOSE 8080

# Command to start llama-server
# CMD ["llama-server", "-m", "/models/default.gguf", "--host", "0.0.0.0", "--port", "8080"]

# Set the entrypoint to the script
ENTRYPOINT ["docker-entrypoint.sh"]
