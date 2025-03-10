{
  description = "Multi-user nix-darwin configuration with flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    darwin,
    home-manager,
    ...
  }: let
    system = "aarch64-darwin";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    # Home Manager configurations
    homeConfigurations = {
      # Jonas's configuration
      jonasschultheiss = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs;
        modules = [
          # Import the main user configuration which imports all other modules
          ./users/jonasschultheiss/default.nix
          # Import shared utilities
          ./modules/shared/utilities/default.nix
        ];
      };

      # Vera's configuration
      verastalder = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs;
        modules = [
          # Import the main user configuration which imports all other modules
          ./users/verastalder/default.nix
          # Import shared utilities
          ./modules/shared/utilities/default.nix
        ];
      };
    };

    # Darwin configurations
    darwinConfigurations.system = darwin.lib.darwinSystem {
      inherit system;
      modules = [
        # Import the main darwin configuration module
        ./modules/darwin/default.nix
      ];
    };

    # One-command builds with native commands
    # Run with: nix run .#build
    apps.${system} = {
      build = {
        type = "app";
        program = toString (pkgs.writeShellScript "build-and-switch" ''
          #!/bin/sh
          set -e

          # Build system configuration
          echo "Building system configuration..."
          nix build .#darwinConfigurations.system.system

          # Apply system configuration
          echo "Applying system configuration..."
          ./result/sw/bin/darwin-rebuild switch --flake .#system

          # Determine current user
          CURRENT_USER=$(whoami)

          # Build and activate home-manager configuration
          echo "Building and activating home-manager configuration for $CURRENT_USER..."

          # Try to build the home-manager configuration
          if nix build .#homeConfigurations.$CURRENT_USER.activationPackage --no-link 2>/dev/null; then
            echo "Using home-manager configuration for $CURRENT_USER"
            nix build .#homeConfigurations.$CURRENT_USER.activationPackage
            ./result/activate
          else
            echo "No home-manager configuration found for $CURRENT_USER"
          fi

          echo "Configuration applied successfully!"
        '');
      };
    };
  };
}
