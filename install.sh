#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print a message with a color
print_message() {
  echo -e "${2}${1}${NC}"
}

# Print a step message
print_step() {
  print_message "==> $1" $BLUE
}

# Print a success message
print_success() {
  print_message "✓ $1" $GREEN
}

# Print an error message
print_error() {
  print_message "✗ $1" $RED
}

# Print a warning message
print_warning() {
  print_message "! $1" $YELLOW
}

# Check if Command Line Tools are installed
check_command_line_tools() {
  print_step "Checking for Command Line Tools..."
  
  if xcode-select -p &>/dev/null; then
    print_success "Command Line Tools are already installed."
  else
    print_step "Installing Command Line Tools..."
    xcode-select --install
    print_warning "Please wait for Command Line Tools to install, then press any key to continue..."
    read -n 1
    print_success "Command Line Tools installed."
  fi
}

# Check if Nix is installed
check_nix() {
  print_step "Checking for Nix..."
  
  if command -v nix &>/dev/null; then
    print_success "Nix is already installed."
  else
    print_step "Installing Nix..."
    sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume
    print_success "Nix installed."
  fi
}

# Enable flakes
enable_flakes() {
  print_step "Enabling flakes..."
  
  mkdir -p ~/.config/nix
  if grep -q "experimental-features" ~/.config/nix/nix.conf 2>/dev/null; then
    print_success "Flakes already enabled."
  else
    echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
    print_success "Flakes enabled."
  fi
}

# Check if nix-darwin is installed
check_darwin() {
  print_step "Checking for nix-darwin..."
  
  if command -v darwin-rebuild &>/dev/null; then
    print_success "nix-darwin is already installed."
  else
    print_step "Installing nix-darwin..."
    nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
    ./result/bin/darwin-installer
    print_success "nix-darwin installed."
  fi
}

# Check if Homebrew is installed
check_homebrew() {
  print_step "Checking for Homebrew..."
  
  if command -v brew &>/dev/null; then
    print_success "Homebrew is already installed."
  else
    print_step "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    print_success "Homebrew installed."
  fi
}

# Build and activate the configuration
build_and_activate() {
  print_step "Building and activating the configuration..."
  
  # Ensure we're in the right directory
  cd ~/.config/nixpkgs
  
  # Commit any changes
  git add .
  git commit -m "Initial configuration" || true
  
  # Build and activate
  darwin-rebuild switch --flake .#system
  
  print_success "Configuration built and activated."
}

# Main function
main() {
  print_message "Starting installation of multi-user nix-darwin configuration..." $BLUE
  
  check_command_line_tools
  check_nix
  enable_flakes
  check_darwin
  check_homebrew
  build_and_activate
  
  print_message "Installation complete! 🎉" $GREEN
  print_message "You can now use 'darwin-rebuild switch --flake ~/.config/nixpkgs#system' to update your configuration." $BLUE
}

# Run the main function
main 