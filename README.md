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
# Then build the configuration
darwin-rebuild switch --flake .#system
```

## Updating

To update your system after making changes to the configuration:

```bash
# Always commit your changes first
git add .
git commit -m "Update configuration"
# Then rebuild
darwin-rebuild switch --flake .#system
```

## Credits

This configuration is based on:
* [Verastalder's dotfiles](https://github.com/verastalder/dotfiles)
* Original nix-darwin configuration by Jonas Schultheiss
