# Dotfiles

My fully-declarative system configuration using Nix and Nix-Darwin.

## Installation

Run at your own risk:

```sh
curl -fsSL https://raw.githubusercontent.com/jonasschultheiss/dotfiles/main/install | bash
```

## Goals

- [x] Installs Command Line Tools silently
- [x] Installs Nix
- [x] Installs Nix-Darwin
- [x] Installs Homebrew
- [x] Clones this repo to the local machine
- [x] Initiates the first `darwin-rebuild` to switch configurations

## Layout

- `darwin/` - Darwin-specific configuration
- `home/` - Home-manager configuration and dotfile management

## Inspiration

Heavily inspired by:

- https://github.com/matchai/dotfiles
- https://github.com/okkdev/dotnix
- https://github.com/TheOptimist/systemosaurus
