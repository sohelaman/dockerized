#!/bin/sh

if [ "$LLAMA_CPP_VISION" = "true" ]; then
    llama-server -m /models/default.gguf --mmproj /models/mmproj.gguf --host 0.0.0.0 --port 8080
else
    llama-server -m /models/default.gguf --host 0.0.0.0 --port 8080
fi
