#!/bin/bash
# Install Script

# Confirm starting process
read -p "Start install? (Y/n): " confirm
confirm=${confirm:-y}

if [[ ! $confirm =~ ^[yY]$ ]]; then
    echo "Installation aborted."
    exit 1
fi

# Define packages
BASE_PACKAGES=(
    policykit-1-gnome
    i3
    polybar
    feh
    rofi
    alacritty
    neovim
    fzf
    zoxide
)

PYENV_DEPENDENCIES=(
    build-essential
    libssl-dev zlib1g-dev
    libbz2-dev
    libreadline-dev
    libsqlite3-dev
    wget
    curl
    llvm
    libncurses5-dev
    libncursesw5-dev
    xz-utils
    tk-dev
    libffi-dev
    liblzma-dev
    python3-openssl
    git
)

# Function - Install packages
install_packages() {
    local packages=("$@")
    sudo apt install -y "${packages[@]}"
}


# Update package lists and install dependencies
echo "Updating and installing base packages..."
sudo apt update && install_packages "${BASE_PACKAGES[@]}"

# Install pyenv dependencies
echo "Installing pyenv dependencies..."
install_packages "${PYENV_DEPENDENCIES[@]}"


# Setup pyenv
setup_pyenv() {
    if command -v pyenv >/dev/null 2>&1; then
        echo "pyenv already installed."
    else
        curl https://pyenv.run | bash
    fi
}

# Setup Rust
setup_rust() {
    if command -v rustup >/dev/null 2>&1; then
        echo "Rust is already installed."
    else
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        rustup update 
    fi
}


# Symlink config dirs
# Set dir to the directory containing the script
CURRENT="$(cd "$(dirname "$0")" && pwd)"
echo "Using source directory: $CURRENT"

# Link config dirs
echo "Linking config dirs..."
for dir in Thunar alacritty i3 nvim polybar rofi yazi zsh; do
    SOURCE_PATH="$CURRENT/.config/$dir"
    TARGET_PATH="$HOME/.config/$dir"
    
    echo "Creating symlink: $SOURCE_PATH -> $TARGET_PATH"
    ln -sf "$SOURCE_PATH" "$TARGET_PATH"

    # Check
    if [[ -L "$TARGET_PATH" && -e "$TARGET_PATH" ]]; then
        echo "✓ $dir"
    else
        echo "! Error $dir"
    fi
done

# Link resources
echo "Linking fonts and wallpaper..."
for dir in fonts wallpaper; do
    SOURCE_PATH="$CURRENT/.local/share/$dir"
    TARGET_PATH="$HOME/.local/share/$dir"
    
    echo "Creating symlink: $SOURCE_PATH -> $TARGET_PATH"
    ln -sf "$SOURCE_PATH" "$TARGET_PATH"

    # Check
    if [[ -L "$TARGET_PATH" && -e "$TARGET_PATH" ]]; then
        echo "✓ $dir"
    else
        echo "! Error $dir"
    fi
done

# Symlink zshrc
echo "Creating symlink for .zshrc..."
ln -sf "$HOME/.config/zsh/.zshrc" "$HOME/.zshrc"
echo "Symlink created: $HOME/.zshrc -> $HOME/.config/zsh/.zshrc"

# Done
echo "All Done!"
echo "To install Yazi, run the following commands..."
echo "exec $SHELL"
echo "cargo install --locked --git https://github.com/sxyazi/yazi.git yazi-fm yazi-cli"
