# Multi-User Nix-Darwin Configuration with Flakes

This repository contains a multi-user nix-darwin configuration using the Nix Flakes approach. It's designed to manage configurations for multiple users on the same macOS system.

## Features

* Declarative macOS system configuration with nix-darwin
* User-level configuration with Home Manager
* Homebrew integration for managing macOS applications
* Fish shell configuration with plugins and themes
* Git configuration and defaults
* macOS system preferences and defaults
* Multi-user support

## Structure

```
.
├── flake.nix              # Flake definition (inputs, outputs)
├── activate.sh            # Script to activate both configurations
├── modules/               # Configuration modules
│   ├── darwin/            # macOS system configuration
│   │   ├── default.nix    # Main darwin configuration
│   │   ├── homebrew.nix   # Homebrew packages and casks
│   │   ├── macos.nix      # macOS defaults
│   │   └── system.nix     # System-level configuration
│   └── home/              # User home configurations
│       ├── jonasschultheiss/  # Jonas's configuration
│       │   ├── default.nix    # Main home-manager config
│       │   └── ...            # Other user-specific configs
│       └── verastalder/       # Vera's configuration
│           ├── default.nix    # Main home-manager config
│           ├── git/           # Git configuration
│           └── shell.nix      # Shell configuration
└── home/                  # Legacy home configuration (for reference)
```

## Installation

### Prerequisites

1. Install Nix:  
```bash
sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume
```

2. Enable flakes:  
```bash
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
```

### Building and Activating

To build and activate the configuration:

```bash
cd ~/.config/nixpkgs
# Commit any local changes first to keep the repository clean
git add .
git commit -m "Update configuration"
# Then build and activate both configurations
./activate.sh
```

Alternatively, you can build and activate each configuration separately:

```bash
# Build and activate nix-darwin system configuration
nix build .#darwinConfigurations.system.system
./result/sw/bin/darwin-rebuild switch --flake .#system

# Build and activate home-manager configuration for jonasschultheiss
nix build .#homeConfigurations.jonasschultheiss.activationPackage
./result/activate

# Build and activate home-manager configuration for verastalder
nix build .#homeConfigurations.verastalder.activationPackage
./result/activate
```

## Updating

To update your system after making changes to the configuration:

```bash
# Always commit your changes first
git add .
git commit -m "Update configuration"
# Then rebuild
./activate.sh
```

## Flake Structure

The flake.nix file is structured to provide both nix-darwin and home-manager configurations:

1. **Darwin Configuration**: Manages system-level settings like:
   - Nix settings (experimental features, auto-optimization)
   - System packages
   - Fish shell system-wide configuration
   - macOS defaults and preferences

2. **Home Manager Configurations**: Manages user-specific settings for each user:
   - User packages
   - Shell configuration
   - Git configuration
   - Other user-specific tools and preferences

This separation allows for a clean distinction between system-wide and user-specific configurations.

## Credits

This configuration is based on:
* [Verastalder's dotfiles](https://github.com/verastalder/dotfiles)
* Original nix-darwin configuration by Jonas Schultheiss
