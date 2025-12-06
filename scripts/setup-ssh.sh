#!/usr/bin/env bash

#=================================================================
# SSH Key Setup Script for GitHub
# Sets up SSH authentication for GitHub access
#=================================================================

set -euo pipefail

#=================================================================
# Logging Functions
#=================================================================

log_info() {
    echo -e "\033[0;34m[INFO]\033[0m $*"
}

log_success() {
    echo -e "\033[0;32m[✓]\033[0m $*"
}

log_error() {
    echo -e "\033[0;31m[ERROR]\033[0m $*" >&2
}

log_warning() {
    echo -e "\033[0;33m[WARNING]\033[0m $*"
}

#=================================================================
# Utility Functions
#=================================================================

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

#=================================================================
# OS Detection
#=================================================================

detect_os() {
    OS="$(uname -s)"
    if [[ "$OS" == "Darwin" ]]; then
        OS="macos"
    elif [[ "$OS" == "Linux" ]]; then
        OS="linux"
    else
        log_error "Unsupported OS: $OS"
        exit 1
    fi
}

#=================================================================
# Main SSH Setup
#=================================================================

main() {
    echo ""
    echo "================================================="
    echo "  GitHub SSH Key Setup"
    echo "================================================="
    echo ""

    # Detect OS
    detect_os

    # Check for required clipboard tools
    if [[ "$OS" == "macos" ]]; then
        if ! command_exists pbcopy; then
            log_error "pbcopy not found"
            exit 1
        fi
    else
        if ! command_exists wl-copy; then
            log_error "wl-copy not found. Please install wl-clipboard first."
            exit 1
        fi
    fi

    log_info "Setting up GitHub SSH authentication..."
    echo ""

    ssh_key_exists=0
    # Check if SSH key already exists
    if [[ -f "$HOME/.ssh/id_ed25519" ]]; then
        echo "SSH key already exists at ~/.ssh/id_ed25519"
        read -p "Use existing key? [Y/n]: " response
        if [[ ! "$response" =~ ^[Nn]$ ]]; then
            ssh_key_exists=1
        fi
    fi

    # Generate new key if needed
    if [[ "$ssh_key_exists" != "1" ]]; then
        read -p "Enter your GitHub email: " github_email
        mkdir -p "$HOME/.ssh"
        ssh-keygen -t ed25519 -C "$github_email" -f "$HOME/.ssh/id_ed25519" -N ""

        # Start ssh-agent and add key
        eval "$(ssh-agent -s)"
        ssh-add "$HOME/.ssh/id_ed25519"
    fi

    # Copy public key to clipboard
    echo ""
    if [[ "$OS" == "macos" ]]; then
        pbcopy < "$HOME/.ssh/id_ed25519.pub"
    else
        wl-copy < "$HOME/.ssh/id_ed25519.pub"
    fi

    log_success "SSH public key copied to clipboard!"
    echo ""
    echo "Please add this key to your GitHub account:"
    echo "  https://github.com/settings/ssh/new"
    echo ""
    read -p "Press Enter after adding the key to GitHub..."

    # Test SSH connection
    echo ""
    log_info "Testing GitHub connection..."
    if ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
        log_success "GitHub SSH authentication successful!"
    else
        log_warning "Could not verify GitHub connection."
        log_warning "Make sure you added the key correctly."
        echo ""
        echo "You can test the connection later by running:"
        echo "  ssh -T git@github.com"
    fi

    echo ""
    log_success "SSH setup complete!"
    echo ""
}

# Run main
main
