{
  description = "Vera's macOS system configuration";

  inputs = {
    # Package sources
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # Environment/system management
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    darwin,
    home-manager,
    ...
  }: let
    # Current system username
    username = "jonasschultheiss"; # Update this to match your username

    # System architecture
    system = "aarch64-darwin"; # Change to x86_64-darwin if you're on Intel

    # Define overlays here so they can be reused
    overlays = [(import ./overlays.nix)];

    # Configure nixpkgs with overlays + allowUnfree
    pkgs = import nixpkgs {
      inherit system overlays;
      config = {
        allowUnfree = true;
      };
    };
  in {
    darwinConfigurations.${username} = darwin.lib.darwinSystem {
      inherit system;
      # Pass overlays to all modules via an early module
      modules = [
        # Make overlays available system-wide
        ({...}: {
          nixpkgs.overlays = overlays;
        })

        # nix-darwin base configuration
        ./modules/darwin

        # Make home-manager work with nix-darwin
        home-manager.darwinModules.home-manager
        {
          nixpkgs.config.allowUnfree = true;
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {inherit inputs overlays;};
            users.${username} = import ./modules/home;
          };
        }
      ];
    };

    # Convenient development shell for bootstrapping
    devShell.${system} = pkgs.mkShell {
      buildInputs = [
        pkgs.nixfmt
      ];
    };

    # Expose overlays so other flakes can consume them
    inherit overlays;
  };
}
