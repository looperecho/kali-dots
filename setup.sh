#!/bin/bash
# Install Script

# Start the process 
read -p "Start install? (Y/n): "
confirm=${confirm:-y}

if [[ $confirm != [yY] ]]; then
    echo "You kept quiet..."
    exit 1
fi

# Update package lists
echo "Updating repo..."
sudo apt update
#sudo apt upgrade -y

# Install
echo "Installing packages..."
sudo apt install -y \
    policykit-1-gnome \
    i3 \
    polybar \
    feh \
    rofi \
    alacritty \
    neovim \
    fzf \
    zoxide

# Setup pyenv
echo "Setting up pyenv..."
# Dependencies
sudo apt install -y \
    build-essential \
    libssl-dev zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    curl \
    llvm \
    libncurses5-dev \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libffi-dev \
    liblzma-dev \
    python3-openssl \
    git
# Install script
curl https://pyenv.run | bash

# Setup Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup update

# Install Yazi
cargo install --locked --git https://github.com/sxyazi/yazi.git yazi-fm yazi-cli

# Copy config dirs
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
        echo "Problem creating symlink for $dir"
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
        echo "Problem creating symlink for $dir"
    fi
done

# Symlink zshrc
echo "Creating symlink for .zshrc..."
ln -sf "$HOME/.config/zsh/.zshrc" "$HOME/.zshrc"
echo "Symlink created: $HOME/.zshrc -> $HOME/.config/zsh/.zshrc"

# Done
echo "All Done!"
