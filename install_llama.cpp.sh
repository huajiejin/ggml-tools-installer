#!/bin/bash

# Exit on any error
set -e

# --- Dependency Management ---
# Function to install Homebrew if not found
install_brew() {
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        # Add brew to path for this script's session
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        echo "Homebrew is already installed."
    fi
}

# Function to check and install packages using Homebrew
check_and_install_packages() {
    for pkg in "$@"; do
        if ! command -v "$pkg" &> /dev/null; then
            echo "$pkg not found. Installing with Homebrew..."
    		install_brew
            brew install "$pkg"
        else
            echo "$pkg is already installed."
        fi
    done
}
# --- End of Dependency Management ---

# Check for required tools
check_and_install_packages "git" "cmake"

# Set project variables
REPO_URL="git@github.com:ggml-org/llama.cpp.git"
INSTALL_DIR="$HOME/.llama.cpp"
BIN_DIR="$INSTALL_DIR/build/bin"
BRANCH_NAME="master"

# Clone or update the repository
if [ -d "$INSTALL_DIR" ]; then
    echo "Updating llama.cpp..."
    cd "$INSTALL_DIR"
    git checkout $BRANCH_NAME && git pull || { echo "Failed to update repository. Please check for local changes or network issues."; exit 1; }
else
    echo "Cloning llama.cpp..."
    git clone "$REPO_URL" "$INSTALL_DIR" || { echo "Failed to clone repository. Please ensure your SSH key is configured on GitHub."; exit 1; }
    cd "$INSTALL_DIR"
	git checkout $BRANCH_NAME
fi

# Build the project
echo "Building llama.cpp..."
cmake -B build
cmake --build build --config Release -j 6

# Add to shell profile if not already present
SHELL_PROFILES=("$HOME/.zshrc" "$HOME/.bashrc" "$HOME/.bash_profile" "$HOME/.profile")
EXPORT_PATH="export PATH=\"\$PATH:$BIN_DIR\""
PATH_ADDED=false

for PROFILE in "${SHELL_PROFILES[@]}"; do
    if [ -f "$PROFILE" ] && ! grep -qF -- "$BIN_DIR" "$PROFILE"; then
        echo "Adding llama.cpp to your PATH in $PROFILE"
        echo -e "\n# Add llama.cpp to PATH\n$EXPORT_PATH" >> "$PROFILE"
        PATH_ADDED=true
        break # Add to the first profile found
    fi
done

if [ "$PATH_ADDED" = true ]; then
    echo "Please restart your terminal or run 'source <your_shell_profile>' to apply changes."
else
    echo "llama.cpp binary path is already configured in your shell profile."
fi

echo "llama.cpp installation complete. Binaries are in: $BIN_DIR"
