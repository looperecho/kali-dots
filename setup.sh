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


# Create symlinks
create_symlink() {
    local source="$1"
    local target="$2"

    ln -sf "$source" "$target"
    if [[ -L "$target" && -e "$target" ]]; then
        echo "✓ Linked $target"
    else
        echo "! Error linking $target"
    fi
}

# Symlink config directories
link_configs() {
    CONFIG_DIRS=(Thunar alacritty i3 nvim polybar rofi yazi zsh)
    for dir in "${CONFIG_DIRS[@]}"; do
        create_symlink "$CURRENT/.config/$dir" "$HOME/.config/$dir"
    done
}

# Symlink fonts and wallpaper
link_resources() {
    RESOURCE_DIRS=(fonts wallpaper)
    for dir in "${RESOURCE_DIRS[@]}"; do
        create_symlink "$CURRENT/.local/share/$dir" "$HOME/.local/share/$dir"
    done
}

# Link zshrc
link_zshrc() {
    create_symlink "$HOME/.config/zsh/.zshrc" "$HOME/.zshrc"
}

# Start setup
CURRENT="$(cd "$(dirname "$0")" && pwd)"
setup_pyenv
setup_rust
link_configs
link_resources
link_zshrc

# Final message
echo "All Done!"
echo "To install Yazi, run the following commands:"
echo "exec $SHELL"
echo "cargo install --locked --git https://github.com/sxyazi/yazi.git yazi-fm yazi-cli"

