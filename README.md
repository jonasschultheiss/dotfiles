# Multi-User Nix Configuration

A multi-user nix-darwin configuration with flakes, supporting user-specific and computer-specific configurations.

## Features

- Multi-user support with Home Manager
- Computer-specific configurations
- Modular design with shared features
- Flake-based for reproducibility
- Darwin/macOS integration

## Structure

```
.
├── computers/              # Computer-specific configurations
│   ├── devenv/             # Configuration for 'devenv' machine
│   └── devenv-pax/         # Configuration for 'devenv-pax' machine
├── modules/                # Shared configuration modules
│   ├── features/           # Feature-specific modules
│   │   ├── git/            # Git configuration
│   │   ├── shell/          # Shell configuration
│   │   └── starship/       # Starship prompt configuration
│   └── os/                 # OS-specific modules
│       └── darwin/         # macOS configuration
├── users/                  # User-specific configurations
│   ├── jonasschultheiss/   # Jonas's configuration
│   └── verastalder/        # Vera's configuration
└── flake.nix               # Main flake configuration
```

## Setup

### Initial Setup

1. Clone this repository to `~/.config/nixpkgs`
2. Install Nix if not already installed: `sh <(curl -L https://nixos.org/nix/install)`
3. Enable flakes by creating `~/.config/nix/nix.conf` with the content:
   ```
   experimental-features = nix-command flakes
   ```

### Building and Switching

The system detects your current hostname and username automatically. To build and apply the configuration:

```
nix run .#build
```

This will:
1. Detect your current hostname and find the matching computer configuration
2. Apply the system-level configuration for that computer
3. Apply the user-level configuration for your username on that computer

### Using a Specific Configuration

If you want to apply a configuration for a specific computer and user:

```
# Format: nix run .#build-COMPUTER-USER
nix run .#build-devenv-jonasschultheiss
nix run .#build-devenv-pax-verastalder
```

## Available Configurations

### Computers
- `devenv` - Standard development environment
- `devenv-pax` - Development environment with additional tools for PAX

### Users
- `jonasschultheiss`
- `verastalder`

## Adding a New User

1. Create a new directory in `users/` with the username
2. Create necessary configuration files
3. Add the user to the `mkUserConfig` mapping in `flake.nix`

## Adding a New Computer

1. Create a new directory in `computers/` with the computer name
2. Create a `default.nix` with computer-specific configuration
3. Add the computer to the `computers` attrset in `flake.nix`

## License

MIT
