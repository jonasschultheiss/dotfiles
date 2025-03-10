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

# Check if the current directory is the nixpkgs config directory
if [[ ! -f "flake.nix" ]]; then
  print_error "This script must be run from the root of your nixpkgs config directory"
  exit 1
fi

# 1. Backup current configuration
print_step "Creating backup of current configuration..."
BACKUP_DIR="$HOME/.config/nixpkgs-backup-$(date +%Y%m%d%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Check if darwin-configuration.nix exists and back it up
if [[ -f "darwin-configuration.nix" ]]; then
  cp -r darwin-configuration.nix "$BACKUP_DIR/"
fi

# Back up other important files
for dir in darwin home; do
  if [[ -d "$dir" ]]; then
    cp -r "$dir" "$BACKUP_DIR/"
  fi
done

print_success "Backup created at $BACKUP_DIR"

# 2. Enable flakes support
print_step "Enabling flakes support in Nix..."
mkdir -p ~/.config/nix
if grep -q "experimental-features" ~/.config/nix/nix.conf 2>/dev/null; then
  print_success "Flakes already enabled."
else
  echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
  print_success "Flakes enabled."
fi

# 3. Ensure we have a clean git state
print_step "Ensuring git repository is in a clean state..."
if [[ -d ".git" ]]; then
  if [[ -n "$(git status --porcelain)" ]]; then
    print_warning "Git repository has uncommitted changes. Committing them now..."
    git add .
    git commit -m "Prepare for transition to flakes-based configuration"
    print_success "Changes committed."
  else
    print_success "Git repository is clean."
  fi
else
  print_warning "Not a git repository. Initializing..."
  git init
  git add .
  git commit -m "Initial commit before flakes transition"
  print_success "Git repository initialized."
fi

# 4. Build the flake without switching
print_step "Building the flake configuration..."
if ! nix build .#darwinConfigurations.system.system; then
  print_error "Failed to build the flake configuration."
  print_message "You can revert to your backup by running:" $YELLOW
  print_message "cp -r $BACKUP_DIR/* $HOME/.config/nixpkgs/" $YELLOW
  exit 1
fi
print_success "Flake configuration built successfully."

# 5. Switch to the flake-based configuration
print_step "Switching to flake-based configuration..."
if ! darwin-rebuild switch --flake .#system; then
  print_error "Failed to switch to flake-based configuration."
  print_message "You can try manually with:" $YELLOW
  print_message "darwin-rebuild switch --flake $HOME/.config/nixpkgs#system" $YELLOW
  print_message "Or revert to your backup by running:" $YELLOW
  print_message "cp -r $BACKUP_DIR/* $HOME/.config/nixpkgs/" $YELLOW
  print_message "darwin-rebuild switch" $YELLOW
  exit 1
fi
print_success "Successfully switched to flake-based configuration!"

# 6. Set up shell alias
print_step "Setting up shell alias for darwin-rebuild..."
SHELL_TYPE=""
if [[ -n "$BASH_VERSION" ]]; then
  SHELL_TYPE="bash"
  SHELL_RC="$HOME/.bashrc"
elif [[ -n "$ZSH_VERSION" ]]; then
  SHELL_TYPE="zsh"
  SHELL_RC="$HOME/.zshrc"
elif [[ "$SHELL" == *"fish"* ]]; then
  SHELL_TYPE="fish"
  SHELL_RC="$HOME/.config/fish/config.fish"
fi

if [[ -n "$SHELL_TYPE" ]]; then
  if [[ "$SHELL_TYPE" == "fish" ]]; then
    ALIAS_CMD='alias darwin-rebuild "darwin-rebuild --flake ~/.config/nixpkgs#system"'
    if ! grep -q "alias darwin-rebuild.*--flake" "$SHELL_RC" 2>/dev/null; then
      echo "$ALIAS_CMD" >> "$SHELL_RC"
      print_success "Added fish alias to $SHELL_RC"
    else
      print_success "Fish alias already exists in $SHELL_RC"
    fi
  else
    ALIAS_CMD='alias darwin-rebuild="darwin-rebuild --flake ~/.config/nixpkgs#system"'
    if ! grep -q "alias darwin-rebuild.*--flake" "$SHELL_RC" 2>/dev/null; then
      echo "$ALIAS_CMD" >> "$SHELL_RC"
      print_success "Added $SHELL_TYPE alias to $SHELL_RC"
    else
      print_success "$SHELL_TYPE alias already exists in $SHELL_RC"
    fi
  fi
else
  print_warning "Could not determine shell type. Please add the following alias to your shell configuration:"
  print_message "alias darwin-rebuild=\"darwin-rebuild --flake ~/.config/nixpkgs#system\"" $YELLOW
fi

# 7. Clean up after successful upgrade
print_step "Cleaning up old configuration files..."
read -p "Do you want to remove the old configuration files now? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  rm -f darwin-configuration.nix
  rm -rf darwin
  rm -rf home
  print_success "Old configuration files removed."
else
  print_message "Old configuration files kept. You can safely remove them later." $YELLOW
fi

print_message "\nMigration to flakes completed successfully! 🎉" $GREEN
print_message "From now on, you can use:" $BLUE
print_message "darwin-rebuild switch" $BLUE
print_message "to update your system if you've set up the alias, or:" $BLUE
print_message "darwin-rebuild switch --flake ~/.config/nixpkgs#system" $BLUE
print_message "if you haven't." $BLUE
print_message "\nYour previous configuration has been backed up to: $BACKUP_DIR" $YELLOW 