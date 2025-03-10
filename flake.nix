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
  } @ inputs: let
    inherit (darwin.lib) darwinSystem;
    inherit (home-manager.lib) homeManagerConfiguration;

    # System architecture
    system = "aarch64-darwin";

    # Configuration for Mac hardware - OS specific modules
    darwinModules = [
      ./modules/os/darwin/default.nix
    ];

    # Function to create specialized arguments for modules
    mkSpecialArgs = {username ? null}: {
      inherit inputs self system;
      flakeDirectory = self.outPath;
      currentUser = username;
    };

    # Function to create user configurations with consistent structure
    mkUserConfig = {
      username,
      email,
    }:
      homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = mkSpecialArgs {inherit username;};
        modules = [
          # Each user's configuration is self-contained
          ./users/${username}/default.nix
        ];
      };
  in {
    # Home Manager configurations
    homeConfigurations = {
      # Jonas's configuration
      jonasschultheiss = mkUserConfig {
        username = "jonasschultheiss";
        email = "jonas.schultheiss@example.com";
      };

      # Vera's configuration
      verastalder = mkUserConfig {
        username = "verastalder";
        email = "vera.stalder@example.com";
      };
    };

    # Darwin configurations
    darwinConfigurations.system = darwinSystem {
      inherit system;
      specialArgs = mkSpecialArgs {};
      modules = darwinModules;
    };

    # One-command builds with native commands
    # Run with: nix run .#build
    apps.${system} = {
      build = {
        type = "app";
        program = toString (nixpkgs.legacyPackages.${system}.writeShellScript "build-and-switch" ''
          #!/bin/sh
          set -e

          # Build system configuration
          echo "Building system configuration..."
          nix build ${self}#darwinConfigurations.system.system --no-link

          # Apply system configuration
          echo "Applying system configuration..."
          ${darwin.packages.${system}.darwin-rebuild}/bin/darwin-rebuild switch --flake ${self}#system

          # Determine current user
          CURRENT_USER=$(whoami)

          # Build and activate home-manager configuration
          echo "Building and activating home-manager configuration for $CURRENT_USER..."

          # Try to build the home-manager configuration
          if nix build ${self}#homeConfigurations.$CURRENT_USER.activationPackage --no-link 2>/dev/null; then
            echo "Using home-manager configuration for $CURRENT_USER"
            ${home-manager.packages.${system}.home-manager}/bin/home-manager switch --flake ${self}#$CURRENT_USER
          else
            echo "No home-manager configuration found for $CURRENT_USER"
          fi

          echo "Configuration applied successfully!"
        '');
      };
    };
  };
}
