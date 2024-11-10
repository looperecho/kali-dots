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
sudo apt upgrade -y

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

# Copy config dirs
# Set dir 
CURRENT="$(cd "$(dirname "${BASH_SOURCE[0]}")/kali-dots" && pwd)"

# Link configs
echo "Linking config dirs..."
for dir in Thunar alacritty i3 nvim polybar rofi yazi zsh; do
    # Create symlinks
    ln -sf "$CURRENT/.config/$dir" "$HOME/.config/$dir"

    # Check
    if [[ -L "$HOME/.config/$dir" && -e "$HOME/.config/$dir" ]]; then
        echo "✓ $dir"
    else
        echo "Problem creating symlink for $dir"
    fi
done

# Link resources
echo "Linking fonts and wallpaper..."
for dir in fonts wallpaper; do
    ln -sf "$CURRENT/.local/share/$dir" "$HOME/.local/share/$dir"
    # Check
    if [[ -L "$HOME/.local/share/$dir" && -e "$HOME/.local/share/$dir" ]]; then
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
