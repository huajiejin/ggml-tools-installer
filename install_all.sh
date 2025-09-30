#!/bin/bash

# This script orchestrates the installation of all GGML tools.
# Each individual script is self-contained and handles its own dependencies.

# Exit on any error
set -e

# Function to run an installer from a URL
run_installer() {
    local name="$1"
    local url="$2"
    echo "--- Starting installation for $name ---"
    /bin/bash -c "$(curl -fsSL $url)"
    echo "--- Finished installation for $name ---"
    echo
}

BASE_URL="https://raw.githubusercontent.com/huajiejin/ggml-tools-installer/main"

# Run installers
run_installer "llama.cpp" "$BASE_URL/install_llama.cpp.sh"
run_installer "whisper.cpp" "$BASE_URL/install_whisper.cpp.sh"
run_installer "llama-swap" "$BASE_URL/install_llama_swap.sh"

echo "All installations are complete."
echo "IMPORTANT: Please close and reopen your terminal, or run 'source <your_shell_profile>' to start using the new commands."
