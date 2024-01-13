#!/bin/bash


# Copid https://medium.com/@anchen.li/replace-grammarly-with-open-source-llm-e1751ad6cad2

# Define the repository and model details
REPO_URL="git@github.com:ggerganov/llama.cpp.git"
REPO_DIR="llama.cpp"
MODEL_URL="https://huggingface.co/TheBloke/Mistral-7B-Instruct-v0.1-GGUF/resolve/main/mistral-7b-instruct-v0.1.Q5_K_M.gguf"
MODEL_FILE="mistral-7b-instruct-v0.1.Q5_K_M.gguf"

# Clone the repository if it doesn't already exist
if [ ! -d "$REPO_DIR" ]; then
  git clone "$REPO_URL"
fi

# Change directory to the cloned repository
cd "$REPO_DIR"

# Build the project using make
# Assume make is idempotent, as it should only rebuild changed files
make

# Change directory to the models folder
mkdir -p models
cd models

# Download the model if it doesn't already exist
if [ ! -f "$MODEL_FILE" ]; then
  wget "$MODEL_URL"
fi

# Change directory back to the project root
cd ../

# Launch the server
./server -m models/"$MODEL_FILE" -c 8192