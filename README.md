# GGML-Tools Installer

This project provides a set of shell scripts to easily download, build, and install the latest versions of [`llama.cpp`](https://github.com/ggml-org/llama.cpp), [`whisper.cpp`](https://github.com/ggml-org/whisper.cpp), and [`llama-swap`](https://github.com/mostlygeek/llama-swap) on **macOS**.

**Why not just install them using Homebrew?**

The scripts help you install the **latest versions** of these tools, which may not be available through Homebrew (It usually takes some time for Homebrew to catch up).

## Quick Install

To install all three tools and their dependencies, run the following command in your terminal:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/huajiejin/ggml-tools-installer/main/install_all.sh)"
```

## Prerequisites & Automatic Installation

These scripts require several command-line tools to function. **You do not need to install them manually.** The installer script will check for them and install any missing tools for you.

- **Required for all scripts**:
  - `git`: For cloning the source code.

- **For `llama.cpp` and `whisper.cpp`**:
  - `cmake`: Used to build the projects.

- **For `llama-swap`**:
  - `node` and `npm`: Used for the UI component.
  - `go`: Used to build the project.

- **Optional**:
  - `Homebrew`: The package manager for macOS, used to install other missing tools. If Homebrew is not found and we need to install any missing tools, the script will install it for you.

## Individual Installers

If you only need a specific tool, you can run its installer individually. Each script will still handle its own dependencies.

- **llama.cpp**:
    ```bash
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/huajiejin/ggml-tools-installer/main/install_llama.cpp.sh)"
    ```
- **whisper.cpp**:
    ```bash
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/huajiejin/ggml-tools-installer/main/install_whisper.cpp.sh)"
    ```
- **llama-swap**:
    ```bash
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/huajiejin/ggml-tools-installer/main/install_llama_swap.sh)"
    ```

## What it does

1.  **Checks for and installs dependencies**: Verifies that `git`, `cmake`, `go`, and `node` are installed, and installs any that are missing.
2.  **Clones or updates repositories**: Downloads the source code to a hidden directory in your home folder (`~/.llama.cpp`, etc.). If it already exists, it pulls the latest changes.
3.  **Builds the projects**: Compiles the source code to create executable binaries optimized for your Mac.
4.  **Updates your shell profile**: Adds the binary paths and a `llama-swap` alias to your `.zshrc` or `.profile` file so you can run the commands from anywhere.


## What it does NOT do?

- Not designed for any other OS except macOS
